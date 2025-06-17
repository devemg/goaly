import 'package:flutter/material.dart';
import 'package:goaly/db/database.dart';
import 'package:goaly/models/reminder_model.dart';

class ReminderProvider with ChangeNotifier {
  final _db = DatabaseHelper();
  final Map<String, List<Reminder>> _remindersByGoal = {};


  List<Reminder> getRemindersForGoal(String goalId) =>
      _remindersByGoal[goalId] ?? [];

  Future<void> loadReminders(String goalId) async {
    _remindersByGoal[goalId] = await _db.getReminders(goalId);
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    await _db.insertReminder(reminder);
    await loadReminders(reminder.goalId);
  }

  Future<void> updateReminder(Reminder reminder) async {
    await _db.updateReminder(reminder);
    await loadReminders(reminder.goalId);
  }

  Future<void> deleteReminder(String id, String goalId) async {
    await _db.deleteReminder(id);
    await loadReminders(goalId);
  }
}
