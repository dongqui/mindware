import 'package:flutter/material.dart';
import 'package:mindware/core/di/service_locator.dart';
import 'package:mindware/features/todo/domain/entities/todo_list.dart';
import 'package:mindware/features/todo/domain/entities/todo_item.dart';
import 'package:mindware/features/todo/domain/usecases/get_todos.dart';
import 'package:mindware/features/todo/domain/usecases/update_todo.dart';

class TodoProvider extends ChangeNotifier {
  // Provider는 상태 관리를 담당합니다.
  // UseCase를 사용하여 비즈니스 로직을 수행하고
  // UI에 필요한 상태를 관리하며 변경을 알립니다.

  final GetTodayTodos _getTodayTodos = getIt<GetTodayTodos>();
  final UpdateTodo _updateTodo = getIt<UpdateTodo>();

  TodoList? _todoList;
  bool _isLoading = false;
  String? _error;

  TodoProvider() {
    loadTodos(); // 초기 데이터 로드
  }

  List<TodoItem> get todos => _todoList?.items ?? [];
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAllCompleted => _todoList?.isCompleted ?? false;

  Future<void> loadTodos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _todoList = await _getTodayTodos();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTodo(TodoItem updatedTodo) async {
    if (_todoList == null) return;

    try {
      final updatedItems = _todoList!.items.map((item) {
        return item.id == updatedTodo.id ? updatedTodo : item;
      }).toList();

      _todoList!.items = updatedItems;

      notifyListeners();

      await _updateTodo(updatedTodo);
    } catch (e) {
      await loadTodos();
      _error = e.toString();
    }
  }
}
