import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Reminder {
  final String? id;
  final String goalId;
  final TimeOfDay time;

  Reminder({this.id, required this.goalId, required this.time});

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      Reminder(id: json['id'], goalId: json['goalId'], time: json['time']);

  Map<String, dynamic> toJson() => {'id': id, 'goalId': goalId, 'time': time};

  factory Reminder.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    final parts = data['time'].split(':');
    return Reminder(
      id: doc.id,
      goalId: data['goalId'],
      time: TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1])),
    );
  }
}
