import 'package:isar/isar.dart';
import '../models/counter_model.dart';
import '../models/todo_model.dart';

abstract class CounterLocalDataSource {
  Future<CounterModel?> getTodayCounter(int todoId);
  Future<void> incrementCounter(int todoId);
  Future<void> createTodayCounter(int todoId);
}

class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  final Isar _isar;

  CounterLocalDataSourceImpl(this._isar);

  @override
  Future<CounterModel?> getTodayCounter(int todoId) async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    return await _isar.counterModels
        .filter()
        .todoIdEqualTo(todoId)
        .dateBetween(startOfDay, endOfDay)
        .findFirst();
  }

  @override
  Future<void> incrementCounter(int todoId) async {
    await _isar.writeTxn(() async {
      final counter = await getTodayCounter(todoId);
      if (counter != null) {
        counter.count++;
        await _isar.counterModels.put(counter);

        // 1000회 달성 시 Todo 완료 처리
        if (counter.count >= 1000) {
          final todo = await _isar.todoModels.get(todoId);
          if (todo != null) {
            todo.isCompleted = true;
            await _isar.todoModels.put(todo);
          }
        }
      }
    });
  }

  @override
  Future<void> createTodayCounter(int todoId) async {
    await _isar.writeTxn(() async {
      final counter = CounterModel(
        date: DateTime.now(),
        todoId: todoId,
      );
      await _isar.counterModels.put(counter);
    });
  }
}
