import 'package:isar/isar.dart';
import '../models/notification_settings_model.dart';

abstract class NotificationLocalDataSource {
  Future<List<NotificationSettingsModel>> getSettings();
  Future<NotificationSettingsModel?> getSetting(int id);
  Future<int> addSetting(NotificationSettingsModel setting);
  Future<bool> removeSetting(int id);
  Future<void> updateSetting(NotificationSettingsModel setting);
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  final Isar _isar;

  NotificationLocalDataSourceImpl(this._isar);

  @override
  Future<List<NotificationSettingsModel>> getSettings() async {
    return await _isar.notificationSettingsModels.where().findAll();
  }

  @override
  Future<NotificationSettingsModel?> getSetting(int id) async {
    return await _isar.notificationSettingsModels.get(id);
  }

  @override
  Future<int> addSetting(NotificationSettingsModel setting) async {
    return await _isar.writeTxn(() async {
      return await _isar.notificationSettingsModels.put(setting);
    });
  }

  @override
  Future<bool> removeSetting(int id) async {
    return await _isar.writeTxn(() async {
      return await _isar.notificationSettingsModels.delete(id);
    });
  }

  @override
  Future<void> updateSetting(NotificationSettingsModel setting) async {
    await _isar.writeTxn(() async {
      await _isar.notificationSettingsModels.put(setting);
    });
  }
}
