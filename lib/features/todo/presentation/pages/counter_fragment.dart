import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';

class CounterFragment extends StatefulWidget {
  final int todoId;

  const CounterFragment({
    super.key,
    required this.todoId,
  });

  @override
  State<CounterFragment> createState() => _CounterFragmentState();
}

class _CounterFragmentState extends State<CounterFragment> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CounterProvider>().loadCounter(widget.todoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<CounterProvider>(
        builder: (context, provider, child) {
          return InkWell(
            onTap: () => provider.increment(widget.todoId),
            child: SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "나는 30대에 100억대 부자가 된다.",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    provider.count.toString(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
