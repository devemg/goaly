import 'package:cloud_firestore/cloud_firestore.dart';

class Goal {
  final String id;
  final String title;
  final String description;
  final List<int> weekDays; // 1 (lunes) a 7 (domingo)
  final String status; // active | inactive
  final DateTime createdAt = DateTime.now();

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.weekDays,
    required this.status,
  });

  factory Goal.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Goal(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      weekDays: List<int>.from(data['weekdays'].map((x) => x.toInt())),
      status: data['status'] ?? 'active',
    );
  }

  Goal copyWith({
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    List<int>? weekDays,
    List<int>? monthDays,
    String? status,
  }) {
    return Goal(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      weekDays: weekDays ?? this.weekDays,
      status: status ?? this.status,
    );
  }
}
