
class Goal {
  final String id;
  final String title;
  final String description;
  final List<int>? weekDays; // 1 (lunes) a 7 (domingo)
  final String status; // active | inactive
  final DateTime createdAt = DateTime.now();

  Goal({
    required this.id,
    required this.title,
    required this.description,
    this.weekDays,
    required this.status,
  });

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    status: json['status'] ?? 'active',
    weekDays: json['weekDays'] != null
        ? List<int>.from(json['weekDays'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    if (weekDays != null) 'weekDays': weekDays,
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
