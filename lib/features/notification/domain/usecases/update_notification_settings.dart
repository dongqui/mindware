import 'package:flutter/material.dart';
import '../repositories/notification_repository.dart';
import '../entities/notification_settings.dart';

class UpdateNotificationSettings {
  final NotificationRepository repository;

  UpdateNotificationSettings(this.repository);

  Future<void> call({
    required bool isEnabled,
    required TimeOfDay time,
    required int id,
    required String title,
    required String body,
  }) async {
    final settings = NotificationSettings(
      id: id,
      isEnabled: isEnabled,
      time: time,
      title: title,
      body: body,
    );
    await repository.updateSetting(settings);
  }
}
