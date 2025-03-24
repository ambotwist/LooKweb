import 'package:flutter/material.dart';
import 'package:website/sections/contact_section.dart';
import 'package:website/sections/faq_section.dart';
import 'package:website/sections/features_section.dart';
import 'package:website/sections/home_section.dart';
import 'package:website/sections/how_it_works_section.dart';
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
  final GlobalKey _contactSectionKey = GlobalKey();
  final List<GlobalKey> _sectionKeys = [GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey()];

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
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HomeSection(
              menuItems: ['How It Works', 'Features', 'FAQ', 'Contact'],
              onPressedCallbacks: [
                () => _scrollToSection(1),
                () => _scrollToSection(2),
                () => _scrollToSection(3),
                () => _scrollToSection(4),
              ],
              scrollController: _scrollController,
            ),
            HowItWorksSection(key: _sectionKeys[0]),
            FeaturesSection(key: _sectionKeys[1]),
            FAQSection(
              key: _sectionKeys[2],
              scrollController: _scrollController,
              contactSectionKey: _contactSectionKey,
            ),
            ContactSection(key: _contactSectionKey),
          ],
        ),
      ),
    );
  }

  void _scrollToSection(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_sectionKeys[index].currentContext != null) {
        final RenderBox renderBox =
            _sectionKeys[index].currentContext!.findRenderObject() as RenderBox;
        final sectionPosition = renderBox.localToGlobal(Offset.zero).dy;

        _scrollController.animateTo(
          sectionPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
