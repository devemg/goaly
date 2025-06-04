class Goal {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String category;
  final DateTime startDate;
  final DateTime endDate;
  final String status; // active | completed | paused | archived
  final DateTime createdAt;

  Goal({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
  });

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
    id: json['id'],
    userId: json['userId'],
    title: json['title'],
    description: json['description'],
    category: json['category'],
    startDate: DateTime.parse(json['startDate']),
    endDate: DateTime.parse(json['endDate']),
    status: json['status'],
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'description': description,
    'category': category,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'status': status,
    'createdAt': createdAt.toIso8601String(),
  };
}
