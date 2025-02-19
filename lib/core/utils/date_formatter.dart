class DateFormatter {
  static String formatToKorean(DateTime date) {
    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year년 $month월 $day일';
  }

  static String formatToKoreanToday() {
    return formatToKorean(DateTime.now());
  }
} 