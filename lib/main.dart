import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/todo/presentation/providers/todo_provider.dart';
import 'features/todo/presentation/providers/counter_provider.dart';
import 'features/todo/presentation/pages/todo_list_page.dart';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<TodoProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<CounterProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MaterialApp(
        title: 'Todo & Progress',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const TodoListPage(),
      ),
    );
  }
}
