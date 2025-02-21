import 'package:flutter/material.dart';
import '../../domain/repositories/notification_repository.dart';

class AddNotification {
  final NotificationRepository repository;

  AddNotification(this.repository);

  Future<void> call({
    required String title,
    required String body,
    required TimeOfDay time,
  }) async {
    await repository.addSetting(
      isEnabled: true,
      time: time,
      title: title,
      body: body,
    );
  }
} 