import 'package:flutter/material.dart';

class FullPageScroller extends StatefulWidget {
  final List<Widget> sections;
  final List<String> sectionTitles;
  final List<VoidCallback> onPressedCallbacks;
  final PageController? pageController;

  const FullPageScroller({
    super.key,
    required this.sections,
    required this.sectionTitles,
    required this.onPressedCallbacks,
    this.pageController,
  });

  @override
  State<FullPageScroller> createState() => _FullPageScrollerState();
}

class _FullPageScrollerState extends State<FullPageScroller> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = widget.pageController ?? PageController();
    _pageController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    // Only dispose the controller if we created it internally
    if (widget.pageController == null) {
      _pageController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_pageController.page!.round() != _currentPage) {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    }
  }

  void scrollToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      children: widget.sections,
    );
  }

  Widget _buildNavDot(int index) {
    return GestureDetector(
      onTap: () => scrollToPage(index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == index
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.withOpacity(0.5),
        ),
      ),
    );
  }
}
