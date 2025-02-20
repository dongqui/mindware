import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mindware/features/todo/presentation/providers/todo_provider.dart';
import 'package:mindware/features/todo/presentation/widgets/todo_item_widget.dart';
import 'package:mindware/core/utils/date_formatter.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormatter.formatToKoreanToday(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Consumer<TodoProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (provider.error != null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '오류가 발생했습니다',
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => provider.loadTodos(),
                              child: const Text('다시 시도'),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: provider.todos.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final todo = provider.todos[index];
                        return TodoItemWidget(
                          id: todo.id,
                          title: todo.title,
                          isCompleted: todo.isCompleted,
                          onToggle: (isCompleted) => provider.updateTodo(
                              todo.copyWith(isCompleted: isCompleted)),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
