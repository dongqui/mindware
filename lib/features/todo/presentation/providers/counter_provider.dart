import 'package:flutter/foundation.dart';
import '../../domain/usecases/get_today_counter.dart';
import '../../domain/usecases/increment_counter.dart';

class CounterProvider extends ChangeNotifier {
  final GetTodayCounter _getTodayCounter;
  final IncrementCounter _incrementCounter;

  int _count = 0;

  CounterProvider(this._getTodayCounter, this._incrementCounter);

  int get count => _count;

  Future<void> loadCounter(int todoId) async {
    final counter = await _getTodayCounter(todoId);
    _count = counter?.count ?? 0;
    notifyListeners();
  }

  Future<void> increment(int todoId) async {
    try {
      _count++;
      notifyListeners();
      await _incrementCounter(todoId);
    } catch (e) {
      await loadCounter(todoId);
    }
  }
}
