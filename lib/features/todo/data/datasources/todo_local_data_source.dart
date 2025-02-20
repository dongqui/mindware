import 'package:isar/isar.dart';
import '../models/todo_model.dart';
import '../models/todo_list_model.dart';

abstract class TodoLocalDataSource {
  // DataSource는 실제 데이터를 가져오는 곳입니다.
  // 로컬 DB(ObjectBox), API 호출, 캐시 등
  // 구체적인 데이터 출처와의 통신을 담당합니다.
  Future<TodoListModel?> getTodayList();
  Future<void> createTodayList();
  Future<void> updateTodoItem(TodoModel todo);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Isar _isar;

  TodoLocalDataSourceImpl(this._isar);

  @override
  Future<TodoListModel?> getTodayList() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    final todoList = await _isar.todoListModels
        .filter()
        .dateBetween(startOfDay, endOfDay)
        .findFirst();

    return todoList;
  }

  @override
  Future<void> createTodayList() async {
    await _isar.writeTxn(() async {
      // 1. TodoList 생성 및 저장
      final todoList = TodoListModel(date: DateTime.now());
      final listId = await _isar.todoListModels.put(todoList);

      // 2. Todo 아이템들 생성 및 저장
      final todos = [
        TodoModel(
          title: '이불 정리하기',
          createdAt: DateTime.now(),
          todoListId: listId,
        ),
        TodoModel(
          title: '아침에 일어나자 마자 감사하기',
          createdAt: DateTime.now(),
          todoListId: listId,
        ),
        TodoModel(
          title: '일어나서 목표 읽기',
          createdAt: DateTime.now(),
          todoListId: listId,
        ),
        TodoModel(
          title: '나 자신과 하이파이브',
          createdAt: DateTime.now(),
          todoListId: listId,
        ),
        TodoModel(
          title: '목표 1000번 말하기',
          createdAt: DateTime.now(),
          todoListId: listId,
        ),
        TodoModel(
          title: '목표 100번 쓰기',
          createdAt: DateTime.now(),
          todoListId: listId,
        ),
        TodoModel(
          title: '자기 전에 목표 읽기',
          createdAt: DateTime.now(),
          todoListId: listId,
        ),
      ];

      await _isar.todoModels.putAll(todos);

      final savedTodos =
          await _isar.todoModels.filter().todoListIdEqualTo(listId).findAll();

      todoList.items.addAll(savedTodos);
      await todoList.items.save();
    });
  }

  @override
  Future<void> updateTodoItem(TodoModel todo) async {
    await _isar.writeTxn(() async {
      print('updateTodoItem@@: ${todo.id}');
      await _isar.todoModels.put(todo);
    });
  }
}
