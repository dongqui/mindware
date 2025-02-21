import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/notification_repository.dart';

class GetNotifications {
  final NotificationRepository repository;

  GetNotifications(this.repository);

  Future<List<NotificationSettings>> call() => repository.getSettings();
} 