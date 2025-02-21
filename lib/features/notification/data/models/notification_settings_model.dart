import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../domain/entities/notification_settings.dart';

part 'notification_settings_model.g.dart';

@collection
class NotificationSettingsModel {
  final Id id;
  final bool isEnabled;
  final int hour;
  final int minute;
  final String title;
  final String body;

  @ignore
  TimeOfDay get time => TimeOfDay(hour: hour, minute: minute);

  NotificationSettingsModel({
    this.id = Isar.autoIncrement,
    required this.isEnabled,
    required this.hour,
    required this.minute,
    required this.title,
    required this.body,
  });

  factory NotificationSettingsModel.fromTime({
    required int id,
    required bool isEnabled,
    required TimeOfDay time,
  }) {
    return NotificationSettingsModel(
      id: id,
      isEnabled: isEnabled,
      hour: time.hour,
      minute: time.minute,
      title: '',
      body: '',
    );
  }

  NotificationSettings toEntity() {
    return NotificationSettings(
      id: id,
      isEnabled: isEnabled,
      time: TimeOfDay(hour: hour, minute: minute),
      title: title,
      body: body,
    );
  }

  factory NotificationSettingsModel.fromEntity(NotificationSettings settings) {
    return NotificationSettingsModel(
      id: settings.id,
      isEnabled: settings.isEnabled,
      hour: settings.time.hour,
      minute: settings.time.minute,
      title: settings.title,
      body: settings.body,
    );
  }
}
