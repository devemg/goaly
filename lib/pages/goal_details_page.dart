import 'package:flutter/material.dart';
import 'package:goaly/app_state.dart';
import 'package:goaly/models/goal_model.dart';
import 'package:goaly/pages/goal_form_page.dart';
import 'package:goaly/styles/sizes.dart';
import 'package:provider/provider.dart';

class GoalDetailsPage extends StatelessWidget {
  final Goal goalDetail;

  const GoalDetailsPage({super.key, required this.goalDetail});

  void _deleteGoal(BuildContext context, String goalId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Goal'),
        content: const Text('Are you sure you want to delete this goal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        final state = Provider.of<MyAppState>(context, listen: false);
        await state.deleteGoal(goalId);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Goal deleted successfully')),
          );

          Navigator.pop(context);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete goal: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Goal Details', style: sectionTitleSty)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(goalDetail.title),
            Text(goalDetail.description),
            Text(goalDetail.status),
            Text('Days: ${goalDetail.weekDays.join(', ')}'),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoalFormPage(goal: goalDetail),
                        ),
                      );
                    },
                    label: Text('Edit Goal'),
                    icon: Icon(Icons.edit),
                  ),
                ),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _deleteGoal(context, goalDetail.id);
                    },
                    label: Text('Delete Goal'),
                    icon: Icon(Icons.delete_forever),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
