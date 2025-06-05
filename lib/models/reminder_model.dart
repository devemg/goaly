class Reminder {
  final int? id;
  final int goalId;
  final String time; // Hora en formato 'HH:mm'

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
