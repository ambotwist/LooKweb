import 'package:flutter/material.dart';
import 'package:website/sections/contact_section.dart';
import 'package:website/sections/faq_section.dart';
import 'package:website/sections/features_section.dart';
import 'package:website/sections/home_section.dart';
import 'package:website/sections/how_it_works_section.dart';
import 'package:website/widgets/app_bar_drawer.dart';
import 'package:website/widgets/big_app_bar.dart';
import 'package:website/widgets/page_controller_widget.dart';
import 'package:website/widgets/small_app_bar.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LooK',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define menu items and callbacks
    final List<String> menuItems = [
      'How It Works',
      'Features',
      'FAQ',
      'Contact'
    ];

    // Create callbacks to scroll to each section
    final List<VoidCallback> onPressedCallbacks = [
      () => _scrollToPage(1), // How It Works (index 1)
      () => _scrollToPage(2), // Features (index 2)
      () => _scrollToPage(3), // FAQ (index 3)
      () => _scrollToPage(4), // Contact (index 4)
    ];

    // Create sections
    final List<Widget> sections = [
      const HomeSection(),
      const HowItWorksSection(),
      const FeaturesSection(),
      const FAQSection(),
      const ContactSection(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // For smaller screens
            if (constraints.maxWidth < 800) {
              return SmallAppBar(
                  menuItems: menuItems, onPressedCallbacks: onPressedCallbacks);
            }

            // For larger screens
            return BigAppBar(
                menuItems: menuItems, onPressedCallbacks: onPressedCallbacks);
          },
        ),
      ),
      endDrawer: AppBarDrawer(
          menuItems: menuItems, onPressedCallbacks: onPressedCallbacks),
      body: FullPageScroller(
        pageController: _pageController,
        sections: sections,
        sectionTitles: ['Home', ...menuItems],
        onPressedCallbacks: [() {}, ...onPressedCallbacks],
      ),
    );
  }

  void _scrollToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
