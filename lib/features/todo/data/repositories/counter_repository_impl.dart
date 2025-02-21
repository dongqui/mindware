import '../../domain/entities/counter.dart';
import '../../domain/repositories/counter_repository.dart';
import '../datasources/counter_local_data_source.dart';

class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource dataSource;

  CounterRepositoryImpl(this.dataSource);

  @override
  Future<Counter?> getTodayCounter(int todoId) async {
    final model = await dataSource.getTodayCounter(todoId);
    if (model == null) {
      await dataSource.createTodayCounter(todoId);
      return null;
    }
    return Counter(
      id: model.id,
      date: model.date,
      todoId: model.todoId,
      count: model.count,
    );
  }

  @override
  Future<void> incrementCounter(int todoId) async {
    await dataSource.incrementCounter(todoId);
  }

  @override
  Future<void> createTodayCounter(int todoId) async {
    await dataSource.createTodayCounter(todoId);
  }
}
