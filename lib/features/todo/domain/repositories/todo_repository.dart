import 'package:mindware/features/todo/domain/entities/todo_item.dart';
import 'package:mindware/features/todo/domain/entities/todo_list.dart';

abstract class TodoRepository {
  // Repository 인터페이스는 도메인 계층에서 필요한 데이터 작업을 정의합니다.
  // 실제 데이터 처리 방법(로컬 DB, 네트워크 등)을 추상화하여
  // 도메인 계층이 데이터 계층에 의존하지 않도록 합니다.
  Future<TodoList?> getTodayList();
  Future<void> createTodayList();
  Future<void> updateTodoItem(TodoItem item);
}
