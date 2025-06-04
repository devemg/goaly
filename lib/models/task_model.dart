class Task {
  final String id;
  final String goalId;
  final String title;
  final bool isCompleted;
  final int order;

  Task({
    required this.id,
    required this.goalId,
    required this.title,
    required this.isCompleted,
    required this.order,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    goalId: json['goalId'],
    title: json['title'],
    isCompleted: json['isCompleted'],
    order: json['order'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'goalId': goalId,
    'title': title,
    'isCompleted': isCompleted,
    'order': order,
  };
}
