import 'package:flutter/material.dart';
import 'package:website/widgets/hamburger_menu.dart';

class SmallAppBar extends StatelessWidget {
  const SmallAppBar({
    super.key,
    required this.menuItems,
    required this.onPressedCallbacks,
  });

  final List<String> menuItems;
  final List<VoidCallback> onPressedCallbacks;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: false,
      toolbarHeight: 80,
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          'look',
          style: TextStyle(
            color: Colors.black,
            fontSize: 42,
            fontWeight: FontWeight.w700,
            fontFamily: 'Martina',
          ),
        ),
      ),
      actions: [
        HamburgerMenu(
          menuItems: menuItems,
          onPressedCallbacks: onPressedCallbacks,
        ),
      ],
    );
  }
}
