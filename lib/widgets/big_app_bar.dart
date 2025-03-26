import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';
import 'package:website/widgets/app_bar_item.dart';

class BigAppBar extends StatelessWidget {
  const BigAppBar({
    super.key,
    required this.menuItems,
    required this.onPressedCallbacks,
  });

  final List<String> menuItems;
  final List<VoidCallback> onPressedCallbacks;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 80,
      surfaceTintColor: Colors.white,
      actions: [
        SizedBox(
          width: 150,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              'look',
              style: TextStyle(
                color: AppTheme.lightTheme.colorScheme.primary,
                fontSize: 42,
                fontWeight: FontWeight.w700,
                fontFamily: 'Martina',
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBarItem(
                    text: menuItems[0], onPressed: onPressedCallbacks[0]),
                AppBarItem(
                    text: menuItems[1], onPressed: onPressedCallbacks[1]),
                AppBarItem(
                    text: menuItems[2], onPressed: onPressedCallbacks[2]),
                AppBarItem(
                    text: menuItems[3], onPressed: onPressedCallbacks[3]),
                // AppBarItem(
                //     text: menuItems[4], onPressed: onPressedCallbacks[4]),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: TextButton(
              onPressed: () {
                onPressedCallbacks[4]();
              },
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
              ),
              child: Text(
                'Contact',
                style: TextStyle(
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Satoshi',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
