import 'package:mindware/features/todo/domain/entities/todo_item.dart';
import 'package:mindware/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<void> call(TodoItem todo) async {
    await repository.updateTodoItem(todo);
  }
}
