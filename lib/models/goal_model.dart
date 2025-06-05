import 'package:goaly/models/reminder_model.dart';

class Goal {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final List<int>? weekDays; // 1 (lunes) a 7 (domingo)
  final List<int>? monthDays; // 1 a 31
  final String status;
  final DateTime createdAt = DateTime.now();
  final List<Reminder>? reminders;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    this.endDate,
    this.weekDays,
    this.monthDays,
    required this.status,
    this.reminders = const [],
  });

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    status: json['status'] ?? 'active',
    startDate: DateTime.parse(json['startDate']),
    endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    weekDays: json['weekDays'] != null
        ? List<int>.from(json['weekDays'])
        : null,
    monthDays: json['monthDays'] != null
        ? List<int>.from(json['monthDays'])
        : null,
    reminders: json['reminders'] != null
        ? List<Reminder>.from(json['reminders'])
        : [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'startDate': startDate.toIso8601String(),
    if (endDate != null) 'endDate': endDate?.toIso8601String(),
    if (weekDays != null) 'weekDays': weekDays,
    if (monthDays != null) 'monthDays': monthDays,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
  };

  Goal copyWith({
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    List<int>? weekDays,
    List<int>? monthDays,
    String? status,
    List<Reminder>? reminders,
  }) {
    return Goal(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      weekDays: weekDays ?? this.weekDays,
      monthDays: monthDays ?? this.monthDays,
      status: status ?? this.status,
      reminders: reminders ?? this.reminders,
    );
  }
}
