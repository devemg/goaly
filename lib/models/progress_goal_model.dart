class ProgressLog {
  final String id;
  final String goalId;
  final DateTime date;
  final String note;
  final String status; // skipped | in_progress | completed
  final String timeLogged;

  ProgressLog({
    required this.id,
    required this.goalId,
    required this.date,
    required this.note,
    required this.status,
    required this.timeLogged,
  });

  factory ProgressLog.fromJson(Map<String, dynamic> json) => ProgressLog(
    id: json['id'],
    goalId: json['goalId'],
    date: DateTime.parse(json['date']),
    note: json['note'],
    status: json['status'],
    timeLogged: json['timeLogged'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'goalId': goalId,
    'date': date.toIso8601String(),
    'note': note,
    'status': status,
    'timeLogged': timeLogged,
  };
}
