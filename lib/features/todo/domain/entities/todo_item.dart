class TodoItem {
  final int id;
  final String title;
  bool isCompleted;
  final DateTime createdAt;

  TodoItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
  });
}
