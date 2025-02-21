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
import '../../features/progress/domain/usecases/get_todo_progress.dart';
import '../../features/progress/presentation/providers/progress_provider.dart';
import '../../features/todo/presentation/providers/todo_provider.dart';
import '../../features/todo/domain/repositories/counter_repository.dart';
import '../../features/todo/data/repositories/counter_repository_impl.dart';
import '../../features/todo/domain/usecases/get_today_counter.dart';
import '../../features/todo/domain/usecases/increment_counter.dart';
import '../../features/notification/data/services/notification_service.dart';
import '../../features/notification/data/repositories/notification_repository_impl.dart';
import '../../features/notification/domain/repositories/notification_repository.dart';
import '../../features/notification/data/models/notification_settings_model.dart';
import '../../features/notification/data/datasources/notification_local_data_source.dart';
import '../../features/notification/presentation/providers/notification_provider.dart';
import '../../features/notification/domain/usecases/get_notifications.dart';
import '../../features/notification/domain/usecases/add_notification.dart';
import '../../features/notification/domain/usecases/remove_notification.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Database
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      TodoModelSchema,
      TodoListModelSchema,
      CounterModelSchema,
      NotificationSettingsModelSchema,
    ],
    directory: dir.path,
    inspector: kDebugMode,
  );

  getIt.registerSingleton<Isar>(isar);

  // Services (먼저 등록)
  final notificationService = NotificationService();
  await notificationService.initialize();
  getIt.registerSingleton<NotificationService>(notificationService);

  // DataSource
  getIt.registerSingleton<TodoLocalDataSource>(
    TodoLocalDataSourceImpl(getIt()),
  );
  getIt.registerSingleton<CounterLocalDataSource>(
    CounterLocalDataSourceImpl(getIt()),
  );
  getIt.registerSingleton<NotificationLocalDataSource>(
    NotificationLocalDataSourceImpl(getIt()),
  );

  // Repository (Service 의존)
  getIt.registerSingleton<TodoRepository>(
    TodoRepositoryImpl(getIt()),
  );
  getIt.registerSingleton<CounterRepository>(
    CounterRepositoryImpl(getIt()),
  );
  getIt.registerSingleton<NotificationRepository>(
    NotificationRepositoryImpl(
      getIt<NotificationLocalDataSource>(),
      getIt<NotificationService>(),
    ),
  );

  // UseCases
  getIt.registerSingleton(GetTodayTodos(getIt()));
  getIt.registerSingleton(UpdateTodo(getIt()));
  getIt.registerSingleton(GetTodoProgress(getIt()));
  getIt.registerSingleton(GetTodayCounter(getIt()));
  getIt.registerSingleton(IncrementCounter(getIt()));

  // Notification UseCases
  getIt.registerSingleton(GetNotifications(getIt<NotificationRepository>()));
  getIt.registerSingleton(AddNotification(getIt<NotificationRepository>()));
  getIt.registerSingleton(RemoveNotification(getIt<NotificationRepository>()));

  // Providers
  getIt.registerFactory(() => TodoProvider());
  getIt.registerFactory(() => CounterProvider(
        getIt<GetTodayCounter>(),
        getIt<IncrementCounter>(),
      ));
  getIt.registerFactory(() => ProgressProvider(getIt()));
  getIt.registerFactory(() => NotificationProvider(
        getIt<GetNotifications>(),
        getIt<AddNotification>(),
        getIt<RemoveNotification>(),
      ));
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
