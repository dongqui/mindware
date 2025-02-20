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

  TodoItem copyWith({bool? isCompleted, String? title, DateTime? createdAt}) {
    return TodoItem(
      id: id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
