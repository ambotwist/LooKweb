import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppBarItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AppBarItem({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: AppTheme.lightTheme.colorScheme.primary,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
