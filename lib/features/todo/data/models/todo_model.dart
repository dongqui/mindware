import 'package:isar/isar.dart';
import '../../domain/entities/todo_item.dart';

part 'todo_model.g.dart';

@collection
class TodoModel {
  // Model은 Entity의 데이터 계층 구현체입니다.
  // JSON 직렬화/역직렬화, DB 매핑 등 외부 데이터 형식과의
  // 변환 로직을 포함합니다.

  Id id = Isar.autoIncrement;

  final String title;
  bool isCompleted;

  @Index()
  final DateTime createdAt;

  @Index()
  final int todoListId;

  TodoModel({
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
    required this.todoListId,
  });

  // Entity -> Model
  factory TodoModel.fromEntity(TodoItem entity, int listId) {
    return TodoModel(
      title: entity.title,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
      todoListId: listId,
    );
  }

  // Model -> Entity
  TodoItem toEntity() {
    return TodoItem(
      id: id,
      title: title,
      isCompleted: isCompleted,
      createdAt: createdAt,
    );
  }
}
