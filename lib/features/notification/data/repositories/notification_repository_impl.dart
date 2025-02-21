import 'package:flutter/material.dart';
import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_local_data_source.dart';
import '../models/notification_settings_model.dart';
import '../services/notification_service.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDataSource _localDataSource;
  final NotificationService _service;

  NotificationRepositoryImpl(this._localDataSource, this._service);

  @override
  Future<List<NotificationSettings>> getSettings() async {
    final models = await _localDataSource.getSettings();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<NotificationSettings?> getSetting(int id) async {
    final model = await _localDataSource.getSetting(id);
    return model?.toEntity();
  }

  @override
  Future<int> addSetting({
    required bool isEnabled,
    required TimeOfDay time,
    required String title,
    required String body,
  }) async {
    final model = NotificationSettingsModel(
      isEnabled: isEnabled,
      hour: time.hour,
      minute: time.minute,
      title: title,
      body: body,
    );
    final id = await _localDataSource.addSetting(model);

    if (isEnabled) {
      await _service.scheduleDaily(
        time: time,
        title: title,
        body: body,
      );
    }

    return id;
  }

  @override
  Future<bool> removeSetting(int id) async {
    return await _localDataSource.removeSetting(id);
  }

  @override
  Future<void> updateSetting(NotificationSettings setting) async {
    final model = NotificationSettingsModel.fromEntity(setting);
    await _localDataSource.updateSetting(model);

    if (setting.isEnabled) {
      await _service.scheduleDaily(
        time: setting.time,
        title: setting.title,
        body: setting.body,
      );
    }
  }

  @override
  Future<void> cancelNotifications() async {
    await _service.cancelAll();
  }
}
