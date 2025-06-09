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
    final goalsSnapshot = await FirebaseFirestore.instance
        .collection('goals')
        .get();
    return goalsSnapshot.docs.map((doc) => Goal.fromFirestore(doc)).toList();
  }

  static Future<void> updateGoal(
    String goalId,
    String title,
    String description,
    List<int> weekDays,
  ) async {
    await database.collection("goals").doc(goalId).update({
      "title": title,
      "description": description,
      "weekdays": weekDays,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  static Future<void> deleteGoal(String goalId) async {
    await database.collection("goals").doc(goalId).delete();
  }
}
