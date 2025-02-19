import '../../domain/entities/todo_item.dart';
import '../../domain/entities/todo_list.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<TodoList?> getTodayList() async {
    final model = await localDataSource.getTodayList();
    return model?.toEntity();
  }

  @override
  Future<void> createTodayList() async {
    await localDataSource.createTodayList();
  }

  @override
  Future<void> updateTodoItem(TodoItem item) async {
    final todoList = await localDataSource.getTodayList();
    if (todoList == null) return;

    final model = TodoModel.fromEntity(item, todoList.id);
    await localDataSource.updateTodoItem(model);
  }
}
