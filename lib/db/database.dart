import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goaly/models/goal_model.dart';

class DatabaseService {
  static FirebaseFirestore? _database;

  static FirebaseFirestore get database {
    _database ??= FirebaseFirestore.instance;
    return _database!;
  }

  static Future<Goal> insertGoal(
    String title,
    String description,
    List<int> weekDays,
  ) async {
    final newGoal = <String, dynamic>{
      "title": title,
      "description": description,
      "weekdays": weekDays,
      "status": "active",
      "createdAt": FieldValue.serverTimestamp(),
    };

    final docRef = await database.collection("goals").add(newGoal);
    final docSnapshot = await docRef.get();

    return Goal.fromFirestore(docSnapshot);
  }

  static Future<List<Goal>> getAllGoals() async {
    // Fetch goal logs from Firebase
    final goalsSnapshot = await FirebaseFirestore.instance
        .collection('goals')
        .get();
    return goalsSnapshot.docs.map((doc) => Goal.fromFirestore(doc)).toList();
  }

  // static Goal? getGoalById(String id) {
  //   try {
  //     return database.firstWhere((g) => g.id == id);
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static void updateGoal(Goal updatedGoal) {
  //   final index = database.indexWhere((g) => g.id == updatedGoal.id);
  //   if (index != -1) {
  //     database[index] = updatedGoal;
  //   }
  // }

  // /// Delete
  // static void deleteGoal(String id) {
  //   database.removeWhere((g) => g.id == id);
  // }

  // /// Optional: Clear all (for testing or reset)
  // static void clearAll() {
  //   database.clear();
  // }
}
