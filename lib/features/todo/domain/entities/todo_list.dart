import 'todo_item.dart';

class TodoList {
  final int id;
  final DateTime date;
  final List<TodoItem> items;
  
  TodoList({
    required this.id,
    required this.date,
    required this.items,
  });

  bool get isCompleted => items.every((item) => item.isCompleted);
} 