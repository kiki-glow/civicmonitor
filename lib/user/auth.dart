import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.themeGradientBackground, // Apply gradient background
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Center the logo and buttons horizontally
            children: [
              Image.asset(
                'assets/icon/logo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity, // Make the button take up full width
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: AppColors.brightBlue, 
                    textStyle: const TextStyle(fontSize: 18), 
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: AppColors.fogGray,
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, 
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: AppColors.brightBlue, 
                    textStyle: const TextStyle(fontSize: 18), 
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: AppColors.fogGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
