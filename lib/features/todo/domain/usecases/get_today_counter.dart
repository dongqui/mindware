import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

class GetTodayCounter {
  final CounterRepository repository;

  GetTodayCounter(this.repository);

  Future<Counter?> call(int todoId) => repository.getTodayCounter(todoId);
} 