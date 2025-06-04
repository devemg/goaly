class Reminder {
  final String id;
  final String goalId;
  final String reminderTime; // e.g., "07:00 AM"
  final String frequency; // daily | weekly | custom
  final List<String>? daysOfWeek; // Optional

  Reminder({
    required this.id,
    required this.goalId,
    required this.reminderTime,
    required this.frequency,
    this.daysOfWeek,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
    id: json['id'],
    goalId: json['goalId'],
    reminderTime: json['reminderTime'],
    frequency: json['frequency'],
    daysOfWeek: json['daysOfWeek'] != null ? List<String>.from(json['daysOfWeek']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'goalId': goalId,
    'reminderTime': reminderTime,
    'frequency': frequency,
    if (daysOfWeek != null) 'daysOfWeek': daysOfWeek,
  };
}
