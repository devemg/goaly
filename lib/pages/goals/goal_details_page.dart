import 'package:flutter/material.dart';
import 'package:goaly/app_state.dart';
import 'package:goaly/db/database.dart';
import 'package:goaly/models/goal_model.dart';
import 'package:goaly/models/reminder_model.dart';
import 'package:goaly/pages/goals/goal_form_page.dart';
import 'package:goaly/styles/sizes.dart';
import 'package:goaly/widgets/reminders_list.dart';
import 'package:provider/provider.dart';

class GoalDetailsPage extends StatefulWidget {
  final Goal goalDetail;

  const GoalDetailsPage({super.key, required this.goalDetail});

  @override
  State<GoalDetailsPage> createState() => _GoalDetailsPageState();
}

class _GoalDetailsPageState extends State<GoalDetailsPage> {
  late List<Reminder> reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  void _loadReminders() async {
    try {
      final list = await DatabaseService.getAllReminders(widget.goalDetail.id);
      setState(() {
        reminders = list;
      });
    } catch (e) {
      print('Error adding the reminder: $e');
    }
  }

  void _addReminder(BuildContext context, String goalId) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (time != null && context.mounted) {
      try {
        final newReminder = await DatabaseService.insertReminder(goalId, time);
        setState(() {
          reminders.add(newReminder);
        });
      } catch (e) {
        print('Error adding the reminder: $e');
      }
    }
  }

  void _updateReminder(String id) async {
    print('update!!!');
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    print(time);
    // if (time != null && context.mounted) {
    //   try {
    //     await DatabaseService.updateReminder(id, time);
    //     final updatedReminders = await DatabaseService.getAllReminders();
    //     setState(() {
    //       reminders = updatedReminders;
    //     });
    //   } catch (e) {
    //     print('Error updating the reminder: $e');
    //   }
    // }
  }

  void _deleteReminder(String id) async {
    if (context.mounted) {
      try {
        await DatabaseService.deleteReminder(id);
        final updatedReminders = await DatabaseService.getAllReminders(widget.goalDetail.id);
        setState(() {
          reminders = updatedReminders;
        });
      } catch (e) {
        print('Error removing the reminder: $e');
      }
    }
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addReminder(context, widget.goalDetail.id);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.goalDetail.title),
            Text(widget.goalDetail.description),
            Text(widget.goalDetail.status),
            Text('Days: ${widget.goalDetail.weekDays.join(', ')}'),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GoalFormPage(goal: widget.goalDetail),
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
                      _deleteGoal(context, widget.goalDetail.id);
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
                _deleteReminder(reminder.id!);
              },
              onUpdate: (reminder) async {
                _updateReminder(reminder.id!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
