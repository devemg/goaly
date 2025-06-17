import 'package:goaly/models/goal_model.dart';
import 'package:goaly/models/reminder_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'goaly.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE goals (
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        weekDays TEXT, -- stored as JSON string
        status TEXT,
        createdAt TEXT
      )
    ''');
    await db.execute('''
  CREATE TABLE reminders (
    id TEXT PRIMARY KEY,
    goalId TEXT,
    time TEXT,
    FOREIGN KEY (goalId) REFERENCES goals (id) ON DELETE CASCADE
  )
''');
  }

  Future<int> insertGoal(Goal goal) async {
    final db = await database;
    return await db.insert(
      'goals',
      goal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Goal>> getGoals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('goals');
    return List.generate(maps.length, (i) => Goal.fromMap(maps[i]));
  }

  Future<int> updateGoal(Goal goal) async {
    final db = await database;
    return await db.update(
      'goals',
      goal.toMap(),
      where: 'id = ?',
      whereArgs: [goal.id],
    );
  }

  Future<int> deleteGoal(String id) async {
    final db = await database;
    return await db.delete('goals', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertReminder(Reminder reminder) async {
    final db = await database;
    await db.insert('reminders', reminder.toJson());
  }

  Future<void> updateReminder(Reminder reminder) async {
  final db = await database;
  await db.update(
    'reminders',
    reminder.toJson(),
    where: 'id = ?',
    whereArgs: [reminder.id],
  );
}

  Future<List<Reminder>> getReminders(String goalId) async {
    final db = await database;
    final result = await db.query(
      'reminders',
      where: 'goalId = ?',
      whereArgs: [goalId],
    );
    return result.map((r) => Reminder.fromJson(r)).toList();
  }

  Future<void> deleteReminder(String id) async {
    final db = await database;
    await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }
}
