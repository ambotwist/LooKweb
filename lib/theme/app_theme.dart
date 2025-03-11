import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: const Color(0xFFFF0055),
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      useMaterial3: true,
      fontFamily: 'Museum',
    );
  }
}
