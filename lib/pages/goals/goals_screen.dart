import 'package:flutter/material.dart';
import 'package:goaly/pages/goals/goal_details_page.dart';
import 'package:goaly/pages/goals/goal_form_page.dart';
import 'package:goaly/providers/goal_provider.dart';
import 'package:goaly/styles/sizes.dart';
import 'package:goaly/widgets/goal_item.dart';
import 'package:goaly/widgets/todays_progress.dart';
import 'package:provider/provider.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<GoalProvider>(context);
    final goals = goalProvider.goals;

    return Scaffold(
      appBar: AppBar(title: const Text('My Goals')),
      body: Column(
              spacing: 10,
              children: [
                TodaysProgress(goals: goals, completedGoals: 0),
                Row(
                  children: [
                    FilledButton.icon(
                      label: Text('Add Goal'),
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GoalFormPage(),
                          ),
                        );
                      },
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
                  children: [
                    Text('Your Goals for Today', style: sectionSubtitleSty),
                    Text('View All', style: linkSty),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: goals.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GoalDetailsPage(currentGoal: goals[index]),
                            ),
                          );
                        },
                        child: GoalItem(goalItem: goals[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
