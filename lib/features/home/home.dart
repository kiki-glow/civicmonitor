import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/icon/logo.png',
              width: 120,
              height: 120,
            ),
            SizedBox(width: 10),
            Text('Dashboard'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.themeGradientBackground,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text('Welcome to CivicMonitor!', style: TextStyle(fontSize: 24, color: AppColors.modernWhite)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cases');
                },
                child: Text('View Cases'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/users');
                },
                child: Text('View Users'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
