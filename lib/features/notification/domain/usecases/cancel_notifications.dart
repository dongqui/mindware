import '../repositories/notification_repository.dart';

class CancelNotifications {
  final NotificationRepository repository;

  CancelNotifications(this.repository);

  Future<void> call() => repository.cancelNotifications();
}
