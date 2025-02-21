import 'package:flutter/material.dart';
import '../../../../core/utils/date_formatter.dart'; // 날짜 포맷팅을 위해 추가

class DayItem extends StatelessWidget {
  final bool isCompleted;
  final int number;
  final DateTime date;
  const DayItem({
    super.key,
    required this.number,
    required this.isCompleted,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: DateFormatter.formatToKorean(date),
      child: Container(
        decoration: BoxDecoration(
          color: isCompleted ? Colors.green.shade100 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isCompleted ? Colors.green : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color:
                    isCompleted ? Colors.green.shade700 : Colors.grey.shade600,
              ),
            ),
            if (isCompleted)
              Icon(
                Icons.check_circle,
                size: 14,
                color: Colors.green.shade700,
              ),
          ],
        ),
      ),
    );
  }
}
