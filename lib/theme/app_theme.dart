import 'package:flutter/material.dart';
import 'package:website/utils/screen_utils.dart';

extension CustomTextTheme on TextTheme {
  TextStyle howItWorkTitle(BuildContext context) => TextStyle(
        color: Colors.white,
        fontSize: getResponsiveFontSize(
          context,
          baseSize: 64,
          minSize: 42,
          maxSize: 64,
        ),
        fontWeight: FontWeight.normal,
      );

  TextStyle howItWorkStep(BuildContext context) => TextStyle(
        color: Colors.white,
        fontSize: getResponsiveFontSize(
          context,
          baseSize: 42,
          minSize: 24,
          maxSize: 48,
        ),
        fontWeight: FontWeight.w600,
      );

  TextStyle howItWorkExplanation(BuildContext context) => TextStyle(
        color: Colors.white,
        fontSize: getResponsiveFontSize(
          context,
          baseSize: 24,
          minSize: 16,
          maxSize: 24,
        ),
        fontWeight: FontWeight.w200,
        fontFamily: 'Museum',
      );

  TextStyle howItWorkExtra(BuildContext context) => TextStyle(
        color: Colors.white,
        fontSize: getResponsiveFontSize(
          context,
          baseSize: 28,
          minSize: 16,
          maxSize: 32,
        ),
        fontWeight: FontWeight.w100,
      );

  /// Responsive version of headlineLarge
  TextStyle responsiveHeadlineLarge(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(
          context,
          baseSize: 38,
          minSize: 32,
          maxSize: 48,
        ),
        fontWeight: FontWeight.bold,
      );

  /// Responsive version of headlineMedium
  TextStyle responsiveHeadlineMedium(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(
          context,
          baseSize: 32,
          minSize: 24,
          maxSize: 40,
        ),
        fontWeight: FontWeight.bold,
      );

  /// Responsive version of headlineSmall
  TextStyle responsiveHeadlineSmall(BuildContext context) => TextStyle(
        fontSize: getResponsiveFontSize(
          context,
          baseSize: 24,
          minSize: 18,
          maxSize: 28,
        ),
      );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: const Color.fromARGB(255, 92, 83, 86),
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      useMaterial3: true,
      fontFamily: 'Satoshi',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
