import 'package:goaly/models/goal_model.dart';

class DatabaseService {
  static List<Goal>? _database;

  static List<Goal> get database {
    _database ??= [];
    return _database!;
  }

  // CRUD GOALS

  static String insertGoal(Goal goal) {
    database.add(goal);
    return goal.id;
  }

  static List<Goal> getGoals() {
    return database;
  }

  static List<Goal> getAllGoals() {
    return List.unmodifiable(database);
  }

  static Goal? getGoalById(String id) {
    try {
      return database.firstWhere((g) => g.id == id);
    } catch (e) {
      return null;
    }
  }

  static void updateGoal(Goal updatedGoal) {
    final index = database.indexWhere((g) => g.id == updatedGoal.id);
    if (index != -1) {
      database[index] = updatedGoal;
    }
  }

  /// Delete
  static void deleteGoal(String id) {
    database.removeWhere((g) => g.id == id);
  }

  /// Optional: Clear all (for testing or reset)
  static void clearAll() {
    database.clear();
  }
}
