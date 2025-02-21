class Counter {
  final int id;
  final DateTime date;
  final int todoId;
  int count;

  Counter({
    required this.id,
    required this.date,
    required this.todoId,
    this.count = 0,
  });
} 