import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'admin_home_screen.dart';
import 'add_new_case_screen.dart';
import 'upload_documents_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const AdminHomeScreen(),
    const AddNewCaseScreen(),
    const UploadDocumentsScreen(),
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
            const SizedBox(width: 20),
            const Text(
              'Admin Dashboard',
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
        //color: AppColors.lightBlue,
        child: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Add Case'),
          BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: 'Upload Documents'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.fogGray,
        unselectedItemColor: AppColors.paleAqua,
        onTap: _onItemTapped,
        backgroundColor: AppColors.brightBlue.withOpacity(0.95),
      ),
    );
  }
}
