import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'user_home_screen.dart';
import 'track_cases_screen.dart';
import 'notifications_screen.dart';
import 'case_updates_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    UserHomeScreen(),
    TrackCasesScreen(),
    NotificationsScreen(),
    CaseUpdatesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.paleAqua,
        title: Row(
          children: [
            Image.asset('assets/icon/logo.png', height: 70),
            const SizedBox(width: 12),
            const Text(
              'User Dashboard',
              style: TextStyle(
                color: AppColors.deepBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.themeGradientBackground,
        ),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Track Cases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Updates',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.fogGray,
        unselectedItemColor: AppColors.paleAqua,
        onTap: _onItemTapped,
        backgroundColor: AppColors.brightBlue.withOpacity(0.95),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }
}
