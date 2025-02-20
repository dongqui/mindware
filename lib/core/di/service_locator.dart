import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import '../../features/todo/data/datasources/todo_local_data_source.dart';
import '../../features/todo/data/repositories/todo_repository_impl.dart';
import '../../features/todo/domain/repositories/todo_repository.dart';
import '../../features/todo/domain/usecases/get_todos.dart';
import '../../features/todo/domain/usecases/update_todo.dart';
import '../../features/todo/data/models/todo_model.dart';
import '../../features/todo/data/models/todo_list_model.dart';
import '../../features/todo/data/models/counter_model.dart';
import '../../features/todo/data/datasources/counter_local_data_source.dart';
import '../../features/todo/presentation/providers/counter_provider.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Database
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      TodoModelSchema,
      TodoListModelSchema,
      CounterModelSchema,
    ],
    directory: dir.path,
    inspector: kDebugMode,
  );

  getIt.registerSingleton<Isar>(isar);

  // DataSource
  getIt.registerSingleton<TodoLocalDataSource>(
    TodoLocalDataSourceImpl(getIt()),
  );
  getIt.registerSingleton<CounterLocalDataSource>(
    CounterLocalDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerSingleton<TodoRepository>(
    TodoRepositoryImpl(getIt()),
  );

  // UseCases
  getIt.registerSingleton(GetTodayTodos(getIt()));
  getIt.registerSingleton(UpdateTodo(getIt()));

  // Providers
  getIt.registerFactory(() => CounterProvider(getIt()));
}

Future<void> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      TodoModelSchema,
      TodoListModelSchema,
      CounterModelSchema,
    ],
    directory: dir.path,
  );
  getIt.registerSingleton<Isar>(isar);
}
