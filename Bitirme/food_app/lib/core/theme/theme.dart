import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';

class MyAppTheme {
  static ThemeData get themeData {
    final defaultTheme = ThemeData();

    return defaultTheme.copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.secondaryTextColor,
          backgroundColor: AppColors.buttonColor,
          fixedSize: const Size(200, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: defaultTheme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryTextButtonColor,
        ),
      ),
    );
  }
}
