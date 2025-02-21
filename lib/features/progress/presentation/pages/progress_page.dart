import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/progress_provider.dart';
import '../../domain/utils/progress_calculator.dart';
import '../widgets/stat_item.dart';
import '../widgets/day_item.dart';
import '../../../../presentation/widgets/error_view.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<ProgressProvider>().loadProgress();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('100일 챌린지'),
      ),
      body: Consumer<ProgressProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return ErrorView(
              onRetry: () => provider.loadProgress(),
            );
          }

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatItem(
                      label: '연속',
                      value:
                          '${ProgressCalculator.calculateStreak(provider.progressList)}일',
                    ),
                    StatItem(
                      label: '성공',
                      value:
                          '${ProgressCalculator.calculateSuccess(provider.progressList)}일',
                    ),
                    StatItem(
                      label: '달성률',
                      value:
                          '${ProgressCalculator.calculateRate(provider.progressList)}%',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    final progress = index < provider.progressList.length
                        ? provider.progressList[index]
                        : null;

                    return DayItem(
                      number: index + 1,
                      date: progress?.date ?? DateTime.now(),
                      isCompleted: progress?.isCompleted ?? false,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
