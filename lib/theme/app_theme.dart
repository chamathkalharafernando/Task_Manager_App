// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Core colors
  static const primaryColor = Color(0xFF2C3E50);
  static const backgroundColor = Color(0xFF34495E);
  static const cardColor = Color(0xFF2980B9);
  static const highlightColor = Color(0xFF1ABC9C);

  // Additional palette
  static const errorColor = Color(0xFFE74C3C);
  static const warningColor = Color(0xFFF39C12);
  static const successColor = Color(0xFF27AE60);
  static const textColor = Colors.white;
  static const secondaryTextColor = Color(0xFFBDC3C7);

  static const cardGradient = LinearGradient(
    colors: [Color(0xFF3498DB), cardColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get theme => ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          secondary: highlightColor,
          error: errorColor,
          background: backgroundColor,
          surface: cardColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: highlightColor,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: cardColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: highlightColor,
            foregroundColor: Colors.white,
            elevation: 2,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: primaryColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: cardColor.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: highlightColor),
          ),
          labelStyle: TextStyle(color: secondaryTextColor),
        ),
      );
}
