import 'package:mindware/features/todo/domain/entities/todo_list.dart';
import 'package:mindware/features/todo/domain/repositories/todo_repository.dart';

class GetTodayTodos {
  final TodoRepository repository;

  GetTodayTodos(this.repository);

  Future<TodoList> call() async {
    final todoList = await repository.getTodayList();

    if (todoList == null) {
      await repository.createTodayList();
      final newList = await repository.getTodayList();

      return newList!;
    }

    return todoList;
  }
}
