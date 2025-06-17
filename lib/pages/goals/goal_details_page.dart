import 'package:flutter/material.dart';
import 'package:goaly/models/goal_model.dart';
import 'package:goaly/models/reminder_model.dart';
import 'package:goaly/pages/goals/goal_form_page.dart';
import 'package:goaly/providers/goal_provider.dart';
import 'package:goaly/providers/reminder_provider.dart';
import 'package:goaly/styles/sizes.dart';
import 'package:goaly/utils/id_generator.dart';
import 'package:goaly/widgets/reminders_list.dart';
import 'package:provider/provider.dart';

class GoalDetailsPage extends StatelessWidget {
  final Goal currentGoal;
  const GoalDetailsPage({super.key, required this.currentGoal});

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
        Provider.of<GoalProvider>(context, listen: false).deleteGoal(goalId);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Goal deleted!')));
        Navigator.pop(context);
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
    final reminderProvider = Provider.of<ReminderProvider>(context);
    final reminders = reminderProvider.getRemindersForGoal(currentGoal.id);
    return Scaffold(
      appBar: AppBar(title: Text('Goal Details', style: sectionTitleSty)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.dial,
          );
          if (time != null) {
            try {
              reminderProvider.addReminder(
                Reminder(
                  goalId: currentGoal.id,
                  time: time,
                  id: generateUuid(),
                ),
              );
            } catch (e) {
              print('Error adding the reminder: $e');
            }
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentGoal.title),
            Text(currentGoal.description),
            Text(currentGoal.status),
            Text('Days: ${currentGoal.weekDays.join(', ')}'),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoalFormPage(goal: currentGoal),
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
                      _deleteGoal(context, currentGoal.id);
                    },
                    label: Text('Delete Goal'),
                    icon: Icon(Icons.delete_forever),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Reminders', style: sectionSubtitleSty)],
            ),
            RemindersList(
              reminders: reminders,
              onDelete: (reminder) async {
                reminderProvider.deleteReminder(reminder.id!, reminder.goalId);
              },
              onUpdate: (reminder) async {
                final TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: reminder.time,
                  initialEntryMode: TimePickerEntryMode.dial,
                );
                if (newTime != null) {
                  final updatedReminder = Reminder(
                    id: reminder.id,
                    goalId: reminder.goalId,
                    time: newTime,
                  );
                  await reminderProvider.updateReminder(updatedReminder);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
