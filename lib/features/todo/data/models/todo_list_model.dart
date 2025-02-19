import 'package:isar/isar.dart';
import '../../domain/entities/todo_list.dart';
import 'todo_model.dart';

part 'todo_list_model.g.dart';

@collection
class TodoListModel {
  Id id = Isar.autoIncrement;

  @Index()
  final DateTime date;

  final IsarLinks<TodoModel> items = IsarLinks<TodoModel>();

  TodoListModel({
    required this.date,
  });

  factory TodoListModel.fromEntity(TodoList entity) {
    return TodoListModel(
      date: entity.date,
    );
  }

  TodoList toEntity() {
    return TodoList(
      id: id,
      date: date,
      items: items.map((item) => item.toEntity()).toList(),
    );
  }
}
