import 'package:flutter/material.dart';
import '../../features/todo/presentation/pages/todo_list_page.dart';
import '../../features/progress/presentation/pages/progress_page.dart';
import '../../features/notification/presentation/pages/notification_settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const TodoListPage(),
    const ProgressPage(),
    const NotificationSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: '오늘의 할 일',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '100일 챌린지',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
      ),
    );
  }
}
