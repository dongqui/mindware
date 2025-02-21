import '../repositories/counter_repository.dart';

class IncrementCounter {
  final CounterRepository repository;

  IncrementCounter(this.repository);

  Future<void> call(int todoId) => repository.incrementCounter(todoId);
} 