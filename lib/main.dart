import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'features/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivicMonitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,  // Set initial scaffold background color
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.modernSecondaryColor, // Using teal as app bar background
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.themeGradientBackground,
          ),
          child: Home(),
        ),
      ),
    );
  }
}

