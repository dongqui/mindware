import 'package:flutter/material.dart';

class NotificationSettings {
  final int id;
  final bool isEnabled;
  final TimeOfDay time;
  final String title;
  final String body;

  NotificationSettings({
    required this.id,
    required this.isEnabled,
    required this.time,
    required this.title,
    required this.body,
  });
}
