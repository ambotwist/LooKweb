import 'package:flutter/material.dart';
import 'package:website/sections/contact_section.dart';
import 'package:website/sections/faq_section.dart';
import 'package:website/sections/for_brands_section.dart';
import 'package:website/sections/home_section.dart';
import 'package:website/sections/how_it_works_section.dart';
import 'package:website/sections/sustainability_section.dart';
import 'package:website/widgets/app_bar_drawer.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'look',
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
  late final ScrollController _scrollController;
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define menu items and callbacks
    final List<String> menuItems = [
      'How It Works',
      'Sustainability',
      'FAQ',
      'For Brands',
      'Contact'
    ];

    // Create callbacks to scroll to each section
    final List<VoidCallback> onPressedCallbacks = [
      () => _scrollToSection(1), // How It Works (index 1)
      () => _scrollToSection(2), // Sustainability (index 2)
      () => _scrollToSection(3), // FAQ (index 3)
      () => _scrollToSection(4), // For Brands (index 4)
      () => _scrollToSection(5), // Contact (index 5)
    ];

    // Create sections with keys for scrolling
    final List<Widget> sections = [
      HomeSection(
        key: _sectionKeys[0],
        menuItems: menuItems,
        onPressedCallbacks: onPressedCallbacks,
        scrollController: _scrollController,
      ),
      HowItWorksSection(key: _sectionKeys[1]),
      SustainabilitySection(key: _sectionKeys[2]),
      FAQSection(key: _sectionKeys[3]),
      ForBrandsSection(key: _sectionKeys[4]),
      ContactSection(key: _sectionKeys[5]),
    ];

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
      endDrawer: AppBarDrawer(
          menuItems: menuItems, onPressedCallbacks: onPressedCallbacks),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(), // Changed from ClampingScrollPhysics to fix trackpad gesture issues
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: sections,
        ),
      ),
    );
  }

  void _scrollToSection(int index) {
    // Need to use post-frame callback to ensure rendering is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_sectionKeys[index].currentContext != null) {
        final RenderBox renderBox =
            _sectionKeys[index].currentContext!.findRenderObject() as RenderBox;
        final sectionPosition = renderBox.localToGlobal(Offset.zero).dy;

        // No need to subtract app bar height anymore
        _scrollController.animateTo(
          sectionPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
