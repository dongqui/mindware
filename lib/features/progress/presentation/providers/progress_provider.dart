import 'package:flutter/foundation.dart';
import '../../domain/usecases/get_todo_progress.dart';

class ProgressProvider extends ChangeNotifier {
  final GetTodoProgress _getTodoProgress;

  List<DailyProgress> _progressList = [];
  bool _isLoading = false;
  String? _error;

  ProgressProvider(this._getTodoProgress);

  List<DailyProgress> get progressList => _progressList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProgress() async {
    _isLoading = true;
    notifyListeners();
    try {
      _progressList = await _getTodoProgress();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
