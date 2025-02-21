import '../usecases/get_todo_progress.dart';

class ProgressCalculator {
  static int calculateStreak(List<DailyProgress> progressList) {
    if (progressList.isEmpty) return 0;

    int streak = 0;
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);

    for (var progress in progressList.reversed) {
      final progressDate = DateTime(
        progress.date.year,
        progress.date.month,
        progress.date.day,
      );

      if (progressDate.difference(todayStart).inDays != -streak) break;
      if (!progress.isCompleted) break;

      streak++;
    }

    return streak;
  }

  static int calculateSuccess(List<DailyProgress> progressList) {
    return progressList.where((p) => p.isCompleted).length;
  }

  static String calculateRate(List<DailyProgress> progressList) {
    if (progressList.isEmpty) return '0';
    final successCount = calculateSuccess(progressList);
    return ((successCount / progressList.length) * 100).toStringAsFixed(1);
  }
} 