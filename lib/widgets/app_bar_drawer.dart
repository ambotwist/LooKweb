import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({
    super.key,
    required this.menuItems,
    required this.onPressedCallbacks,
  });

  final List<String> menuItems;
  final List<VoidCallback> onPressedCallbacks;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppTheme.lightTheme.colorScheme.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
              child: Text(
                'look',
                style: TextStyle(
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Martina',
                ),
              ),
            ),
            for (int i = 0; i < menuItems.length; i++)
              ListTile(
                title: Text(
                  menuItems[i],
                  style: TextStyle(
                    color: AppTheme.lightTheme.colorScheme.onPrimary,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  onPressedCallbacks[i]();
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}
