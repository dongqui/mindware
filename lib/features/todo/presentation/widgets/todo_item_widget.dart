import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final VoidCallback onToggle;
  final bool hasCounter;
  final VoidCallback? onCounterTap;

  const TodoItemWidget({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.onToggle,
    this.hasCounter = false,
    this.onCounterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                // Checkbox
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.blue : Colors.transparent,
                    border: Border.all(
                      color: isCompleted ? Colors.blue : Colors.grey.shade400,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: isCompleted
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                      decorationColor: Colors.grey.shade400,
                    ),
                  ),
                ),
                // Counter Button (if needed)
                if (hasCounter) ...[
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: onCounterTap,
                    icon: Icon(
                      Icons.format_list_numbered,
                      color: Colors.blue.shade300,
                    ),
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(40, 40),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
