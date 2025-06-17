import 'package:flutter/foundation.dart';
import 'package:goaly/db/database.dart';
import 'package:goaly/models/goal_model.dart';

class GoalProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Goal> _goals = [];

  List<Goal> get goals => _goals;

  Future<void> loadGoals() async {
    _goals = await _dbHelper.getGoals();
    notifyListeners();
  }

  Future<void> addGoal(Goal goal) async {
    await _dbHelper.insertGoal(goal);
    await loadGoals();
  }

  Future<void> deleteGoal(String id) async {
    await _dbHelper.deleteGoal(id);
    await loadGoals();
  }

  Future<void> updateGoal(Goal updatedGoal) async {
    await _dbHelper.updateGoal(updatedGoal);
    await loadGoals();
  }
}
