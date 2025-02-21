import '../../../todo/domain/repositories/todo_repository.dart';

class GetTodoProgress {
  final TodoRepository todoRepository;

  GetTodoProgress(this.todoRepository);

  Future<List<DailyProgress>> call() async {
    final allLists = await todoRepository.getAllLists();
    final List<DailyProgress> progressList = [];

    // 최근 100일치 데이터만 필터링
    final today = DateTime.now();
    final hundredDaysAgo = today.subtract(const Duration(days: 100));

    for (var todoList in allLists) {
      if (todoList.date.isAfter(hundredDaysAgo)) {
        progressList.add(
          DailyProgress(
            date: todoList.date,
            isCompleted: todoList.isCompleted,
          ),
        );
      }
    }

    // 날짜순 정렬 (오래된 날짜부터)
    progressList.sort((a, b) => a.date.compareTo(b.date));
    
    return progressList;
  }
}

class DailyProgress {
  final DateTime date;
  final bool isCompleted;

  DailyProgress({
    required this.date,
    required this.isCompleted,
  });
} 