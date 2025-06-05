import 'package:flutter/material.dart';
import 'package:goaly/db/database.dart';
import 'package:goaly/models/goal_model.dart';
import 'package:goaly/utils/id_generator.dart';
import 'package:goaly/widgets/goals_list.dart';
import 'package:goaly/widgets/header.dart';
import 'package:goaly/widgets/todays_progress.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Goal> goals = [];
  int completedGoals = 0;

  @override
  void initState() {
    super.initState();
    _setGoals();
  }

  void _setGoals() {
    var allGoals = DatabaseService.getGoals();
    setState(() {
      goals = allGoals;
      completedGoals = allGoals.where((g) => g.status == 'completed').length;
    });
  }

  void _addGoal() {
    DatabaseService.insertGoal(
      Goal(
        id: generateUuid(),
        title: 'Goal 1',
        description: 'Desc',
        startDate: DateTime.now(),
        status: 'active',
      ),
    );
    _setGoals();
  }

  void _completeGoal(String id) {
    var goal = DatabaseService.getGoalById(id);
    if (goal != null) {
      final updatedGoal = goal.copyWith(status: 'completed');
      DatabaseService.updateGoal(updatedGoal);
      _setGoals();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TodaysProgress(total: goals.length, completed: completedGoals),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            spacing: 10,
            children: [
              Row(
                children: [
                  FilledButton.icon(
                    label: Text('Add Goal'),
                    icon: Icon(Icons.add),
                    onPressed: _addGoal,
                  ),
                  SizedBox(width: 10),
                  FilledButton.tonalIcon(
                    label: Text('View Stats'),
                    icon: Icon(Icons.stacked_bar_chart_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Your Goals for Today'), Text('View All')],
              ),
            ],
          ),
        ),
        GoalsList(
          goals: goals,
          onChanged: (value) {
            _completeGoal(value);
          },
        ),
      ],
    );
  }
}
