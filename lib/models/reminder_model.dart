import 'package:flutter/material.dart';

class Reminder {
  final int? id;
  final String goalId;
  final TimeOfDay time;

  Reminder({this.id, required this.goalId, required this.time});

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        id: json['id'],
        goalId: json['goalId'],
        time: json['time'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'goalId': goalId,
        'time': time,
      };
}
