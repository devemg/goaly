import 'dart:async';
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:goaly/db/database.dart';
import 'package:goaly/models/goal_model.dart';

class MyAppState extends ChangeNotifier {
  final List<Goal> _goals = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  StreamSubscription<User?>? _authSubscription;

  UnmodifiableListView<Goal> get goals => UnmodifiableListView(_goals);
  int get completedGoals => _goals.where((g) => g.status == 'completed').length;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  MyAppState() {
    _authSubscription = _auth.authStateChanges().listen((user) {
      _currentUser = user;
      _loadGoals(); // Load goals when auth changes
      notifyListeners();
    });
  }

  Future<void> _loadGoals() async {
    if (_currentUser == null) {
      _goals.clear();
      notifyListeners();
      return;
    }
    try {
      final goalsList = await DatabaseService.getAllGoals();
      _goals.clear();
      _goals.addAll(goalsList);
      notifyListeners();
    } catch (e) {
      print('Error loading goals: $e');
    }
  }

  Future<void> addGoal({
    required String title,
    required String description,
    required List<int> weekDays,
  }) async {
    try {
      // Add to database
      final newGoal = await DatabaseService.insertGoal(
        title,
        description,
        weekDays,
      );
      // Add to local state
      _goals.add(newGoal);
      notifyListeners();
    } catch (e) {
      print('Error adding goal: $e');
    }
  }

  Future<void> deleteGoal(String goalId) async {
    try {
      // delete from db
      await DatabaseService.deleteGoal(goalId);
      //delete from local state
      _goals.removeWhere((goal) => goal.id == goalId);
      notifyListeners();
    } catch (e) {
      print('Error deleting goal: $e');
    }
  }

  Future<void> updateGoal({
    required String goalId,
    required String title,
    required String description,
    required List<int> weekDays,
  }) async {
    try {
      // update in db
      await DatabaseService.updateGoal(goalId, title, description, weekDays);
      // update in local state
      final index = _goals.indexWhere((g) => g.id == goalId);
      if (index != -1) {
        _goals[index] = _goals[index].copyWith(
          title: title,
          description: description,
          weekDays: weekDays,
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error updating goal: $e');
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
