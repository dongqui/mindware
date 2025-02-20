import 'package:flutter/material.dart';
import 'package:mindware/features/todo/presentation/pages/counter_fragment.dart';
import 'package:mindware/features/todo/presentation/pages/goal_fragment.dart';

class TodoItemWidget extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final Function(bool) onToggle;
  final int id;

  const TodoItemWidget({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.onToggle,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          // Checkbox
          Checkbox(
            value: isCompleted,
            onChanged: (isCompleted) {
              onToggle(isCompleted!);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            activeColor: Colors.blue,
          ),

          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                decorationColor: Colors.grey.shade400,
              ),
            ),
          ),

          if (title == '목표 1000번 말하기')
            // 일단 대충...
            IconButton(
              onPressed: () => showCounterFragment(context),
              icon: const Icon(Icons.record_voice_over),
            ),

          if (title == '일어나서 목표 읽기' || title == '자기 전에 목표 읽기')
            IconButton(
              onPressed: () => showGoalFragment(context),
              icon: const Icon(Icons.menu_book),
            ),
        ],
      ),
    );
  }

  void showCounterFragment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CounterFragment(
          todoId: id,
        ),
      ),
    );
  }

  void showGoalFragment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => GoalFragment()),
    );
  }
}
