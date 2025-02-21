import 'package:flutter/material.dart';
import '../../domain/entities/notification_settings.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/add_notification.dart';
import '../../domain/usecases/remove_notification.dart';

class NotificationProvider extends ChangeNotifier {
  final GetNotifications _getNotifications;
  final AddNotification _addNotification;
  final RemoveNotification _removeNotification;
  List<NotificationSettings> _alarms = [];

  NotificationProvider(
    this._getNotifications,
    this._addNotification,
    this._removeNotification,
  ) {
    _loadAlarms();
  }

  List<NotificationSettings> get alarms => _alarms;

  Future<void> _loadAlarms() async {
    _alarms = await _getNotifications();
    notifyListeners();
  }

  Future<void> addAlarm({
    required String title,
    required String body,
    required TimeOfDay time,
  }) async {
    await _addNotification(
      title: title,
      body: body,
      time: time,
    );
    await _loadAlarms();
  }

  Future<void> removeAlarm(int id) async {
    await _removeNotification(id);
    await _loadAlarms();
  }
}
