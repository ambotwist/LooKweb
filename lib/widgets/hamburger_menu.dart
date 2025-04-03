import 'package:flutter/material.dart';

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
        color: Colors.black,
        size: 28,
      ),
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
    );
  }
}
