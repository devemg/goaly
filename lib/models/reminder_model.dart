import 'package:flutter/material.dart';

class Reminder {
  final String? id;
  final String goalId;
  final TimeOfDay time;

  Reminder({this.id, required this.goalId, required this.time});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    final timeParts = (json['time'] as String).split(':');
    return Reminder(
      id: json['id'],
      goalId: json['goalId'],
      time: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'goalId': goalId,
        'time': '${time.hour}:${time.minute}',
      };
}
