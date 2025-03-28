import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HamburgerMenu extends StatelessWidget {
  final List<String> menuItems;
  final List<VoidCallback> onPressedCallbacks;

  const HamburgerMenu({
    super.key,
    required this.menuItems,
    required this.onPressedCallbacks,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: AppTheme.lightTheme.colorScheme.onPrimary,
        size: 28,
      ),
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
    );
  }
}
