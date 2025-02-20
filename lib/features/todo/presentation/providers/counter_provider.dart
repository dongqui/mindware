import 'package:flutter/foundation.dart';
import '../../data/datasources/counter_local_data_source.dart';

class CounterProvider extends ChangeNotifier {
  final CounterLocalDataSource _dataSource;

  int _count = 0;

  CounterProvider(this._dataSource);

  int get count => _count;

  Future<void> loadCounter(int todoId) async {
    final counter = await _dataSource.getTodayCounter(todoId);
    if (counter == null) {
      await _dataSource.createTodayCounter(todoId);
      _count = 0;
    } else {
      _count = counter.count;
    }
    notifyListeners();
  }

  Future<void> increment(int todoId) async {
    try {
      _count++;
      notifyListeners();
      await _dataSource.incrementCounter(todoId);
    } catch (e) {
      await loadCounter(todoId);
    }
  }
}
