import 'dart:convert';

class Goal {
  final String id;
  final String title;
  final String description;
  final List<int> weekDays;
  final String status;
  final DateTime createdAt;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.weekDays,
    required this.status,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Goal copyWith({
    String? title,
    String? description,
    List<int>? weekDays,
    String? status,
  }) {
    return Goal(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      weekDays: weekDays ?? this.weekDays,
      status: status ?? this.status,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'weekDays': jsonEncode(weekDays),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      weekDays: List<int>.from(jsonDecode(map['weekDays'])),
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
