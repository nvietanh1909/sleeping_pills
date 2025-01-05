import 'package:flutter/material.dart';
import 'package:sleeping_pills/ui/sleep/SleepScreen.dart'; 
import 'package:sleeping_pills/ui/daily/DailyScreen.dart';
import 'package:sleeping_pills/ui/statistic/StatisticScreen.dart';
import 'package:sleeping_pills/ui/profile/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    SleepApp(),
    DailyScreen(),
    StatisticScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Chuyển sang màn hình đã chọn
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 33, 31, 52),
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.grey,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.nightlight_round),
            label: 'Sleep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Daily',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
