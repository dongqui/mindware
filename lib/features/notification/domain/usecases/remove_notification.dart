import '../../domain/repositories/notification_repository.dart';

class RemoveNotification {
  final NotificationRepository repository;

  RemoveNotification(this.repository);

  Future<void> call(int id) async {
    await repository.removeSetting(id);
    await repository.cancelNotifications();

    final alarms = await repository.getSettings();
    for (var alarm in alarms) {
      if (alarm.isEnabled) {
        await repository.addSetting(
          isEnabled: true,
          time: alarm.time,
          title: alarm.title,
          body: alarm.body,
        );
      }
    }
  }
}
