import 'package:flutter/material.dart';

class AppColors {
  static const Color darkBlueGrey = Color(0xFF3D5A80); // Dark Blue Grey
  static const Color lightBlue = Color(0xFF98C1D9); // Light Blue
  static const Color paleAqua = Color(0xFFE0FBFC); // Pale Aqua
  static const Color coralRed = Color(0xFFEE6C4D); // Coral Red
  static const Color charcoalBlue = Color(0xFF293241); // Charcoal Blue
  static const Color fogGray = Color(0xFFF2F4F7);
  static const Color white = Color(0xFFFFFFFF); // White
  static const Color veryDarkBlue = Color(0xFF00171F); // Very Dark Blue
  static const Color darkBlue = Color(0xFF003459); // Dark Blue
  static const Color brightBlue = Color(0xFF077EA7); // Bright Blue
  static const Color vividBlue = Color(0xFF00A8E8); // Vivid Blue
  static const Color deepBlue = Color(0xFF03045E); // Deep Blue
  static const Color oceanBlue = Color(0xFF0077B6); // Ocean Blue
  static const Color skyBlue = Color(0xFF00B4D8); // Sky Blue
  static const Color lightSkyBlue = Color(0xFF90E0EF); // Light Sky Blue
  static const Color veryPaleBlue = Color(0xFFCAF0F8); // Very Pale Blue

  // Gradient Theme Background with Bright Colors
  static const LinearGradient themeGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      brightBlue,   // Bright Blue
      vividBlue,    // Vivid Blue
      skyBlue,      // Sky Blue
      lightSkyBlue, // Light Sky Blue
      veryPaleBlue, // Very Pale Blue
    ],
  );
}
