import 'package:flutter/material.dart';
import '../entities/notification_settings.dart';

abstract class NotificationRepository {
  Future<List<NotificationSettings>> getSettings();
  Future<NotificationSettings?> getSetting(int id);
  Future<int> addSetting({
    required bool isEnabled,
    required TimeOfDay time,
    required String title,
    required String body,
  });
  Future<bool> removeSetting(int id);
  Future<void> updateSetting(NotificationSettings setting);
  Future<void> cancelNotifications();
}
