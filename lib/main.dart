import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:goaly/db/database.dart';
import 'package:goaly/models/goal_model.dart';
import 'package:goaly/models/goal_progress_model.dart';
import 'package:goaly/models/user_model.dart';
import 'package:goaly/pages/public/main_public_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Goaly',
        theme:
            ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
            ).copyWith(
              filledButtonTheme: FilledButtonThemeData(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),
        home: MainPublicPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final List<Goal> _goals = [];
  final List<GoalProgressLog> _goalsLog = [];
  UnmodifiableListView<Goal> get goals => UnmodifiableListView(_goals);
  UnmodifiableListView<GoalProgressLog> get goalsLog =>
      UnmodifiableListView(_goalsLog);
  int get completedGoals => _goals.where((g) => g.status == 'completed').length;
  final user = User(
    name: 'Emely',
    email: 'garciam.emm@gmail.com',
    avatar:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHx1c2VyfGVufDB8fHx8MTc0ODk5OTI3N3ww&ixlib=rb-4.1.0&q=80&w=1080',
  );

  MyAppState() {
    _loadInitialData();
  }
  Future<void> _loadInitialData() async {
    try {
      final goalsList = await DatabaseService.getAllGoals();
      _goals.clear();
      _goals.addAll(goalsList);
      notifyListeners();
    } catch (e) {
      print('Error loading initial data: $e');
    }
  }

  Future<void> add({
    required String title,
    required String description,
    required List<int> weekDays,
  }) async {
    // Add to database
    final newGoal = await DatabaseService.insertGoal(
      title,
      description,
      weekDays,
    );
    // Add to local state
    _goals.add(newGoal);
    notifyListeners();
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
      rethrow;
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
      rethrow;
    }
  }
}
