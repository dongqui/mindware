import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'features/todo/presentation/providers/todo_provider.dart';
import 'features/todo/presentation/providers/counter_provider.dart';
import 'core/di/service_locator.dart';
import 'presentation/pages/main_page.dart';
import 'features/progress/presentation/providers/progress_provider.dart';
import 'features/notification/presentation/providers/notification_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await setupDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<TodoProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<CounterProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<ProgressProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<NotificationProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindWare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
