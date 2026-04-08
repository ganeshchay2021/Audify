import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/core/config/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  //light Theme data
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    fontFamily: "Satoshi",
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        textStyle: AppTextStyle.lightlineTextStyle(
          16,
        ).copyWith(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.primary.withOpacity(0.3),
      selectionHandleColor: AppColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(fontSize: 20, color: Colors.black38),
      fillColor: Colors.transparent,
      filled: false,
      contentPadding: EdgeInsets.all(20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: AppColors.whiteColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
  );

  //Dark Theme data
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: "Satoshi",
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.primary.withOpacity(0.3),
      selectionHandleColor: AppColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
      fillColor: Colors.transparent,
      filled: false,
      contentPadding: EdgeInsets.all(20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.whiteColor,
        textStyle: AppTextStyle.lightlineTextStyle(
          16,
        ).copyWith(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
  );
}
