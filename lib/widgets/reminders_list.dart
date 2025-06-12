import 'package:flutter/material.dart';
import 'package:goaly/models/reminder_model.dart';

class RemindersList extends StatelessWidget {
  final List<Reminder> reminders;
  final Future<void> Function(Reminder) onDelete;
  final Future<void> Function(Reminder) onUpdate;

  const RemindersList({
    super.key,
    required this.reminders,
    required this.onDelete,
    required this.onUpdate,
  });

  void _showReminderDetails(BuildContext context, Reminder reminder) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reminder Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text('Time: ${reminder.time.format(context)}'),
              // Add more details from your Reminder model
              const Spacer(),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: () async {
                      await onUpdate(reminder);
                      if (context.mounted) Navigator.pop(context);
                    },
                    child: const Text('Edit'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await onDelete(reminder);
                      if (context.mounted) Navigator.pop(context);
                    },
                    child: const Text('Delete'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: reminders.length,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          final currentReminder = reminders[index];
          return GestureDetector(
            onTap: () {
              _showReminderDetails(context, currentReminder);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(currentReminder.time.format(context)),
              ),
            ),
          );
        },
      ),
    );
  }
}
