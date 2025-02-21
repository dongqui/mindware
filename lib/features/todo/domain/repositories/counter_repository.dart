import '../entities/counter.dart';

abstract class CounterRepository {
  Future<Counter?> getTodayCounter(int todoId);
  Future<void> incrementCounter(int todoId);
  Future<void> createTodayCounter(int todoId);
} 