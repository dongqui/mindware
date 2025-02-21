import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_provider.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 설정'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAlarmDialog(context),
        child: const Icon(Icons.add_alarm),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: provider.alarms.isEmpty
                      ? const Center(
                          child: Text('등록된 알림이 없습니다'),
                        )
                      : ListView.builder(
                          itemCount: provider.alarms.length,
                          itemBuilder: (context, index) {
                            final alarm = provider.alarms[index];
                            return ListTile(
                              title: Text(alarm.title),
                              subtitle: Text(alarm.time.format(context)),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => provider.removeAlarm(alarm.id),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _showAddAlarmDialog(BuildContext context) async {
    final titleController = TextEditingController();
    TimeOfDay selectedTime = TimeOfDay.now();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('알림 추가'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: '알림 제목',
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('알림 시간'),
              trailing: Text(selectedTime.format(context)),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (time != null) {
                  selectedTime = time;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                context.read<NotificationProvider>().addAlarm(
                      title: titleController.text,
                      body: '알림이 도착했습니다',
                      time: selectedTime,
                    );
                Navigator.pop(context);
              }
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }
}
