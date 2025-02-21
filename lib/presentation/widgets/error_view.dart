import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  final String? message;

  const ErrorView({
    super.key,
    required this.onRetry,
    this.message = '오류가 발생했습니다',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message!,
            style: TextStyle(color: Colors.red.shade700),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }
} 