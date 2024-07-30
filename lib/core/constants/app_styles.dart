import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static const TextStyle header = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.onBackground,
  );

  static const TextStyle subHeader = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: AppColors.onBackground,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16.0,
    color: AppColors.onBackground,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.onPrimary,
  );
}
