import 'package:flutter/material.dart';

class AppColors {
  // Modern and Clean Theme
  static const Color modernPrimaryColor = Color(0xFF00796B);
  static const Color modernSecondaryColor = Color(0xFFFF6F61);
  static const Color modernAccentColor = Color(0xFFFBC02D);
  static const Color modernWhite = Color(0xFFFFFFFF);
  static const Color modernCharcoal = Color(0xFF333333);

  // Government and Civic Engagement Theme
  static const Color govPrimaryColor = Color(0xFF003366);
  static const Color govSecondaryColor = Color(0xFFD32F2F);
  static const Color govAccentColor = Color(0xFFFFB300);
  static const Color govOffWhite = Color(0xFFFAFAFA);
  static const Color govMidGrey = Color(0xFF757575);

  // Gradient Theme Background
  static const LinearGradient themeGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      modernPrimaryColor,    // Teal
      modernSecondaryColor,  // Coral
      modernAccentColor,     // Yellow
    ],
  );
}
