import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:website/theme/app_theme.dart';
import 'package:website/widgets/big_app_bar.dart';
import 'package:website/widgets/small_app_bar.dart';

double getResponsiveFontSize(
  BuildContext context, {
  required double baseSize,
  required double minSize,
  required double maxSize,
}) {
  // Get the screen width
  double screenWidth = MediaQuery.of(context).size.width;

  // Calculate the font size based on screen width
  double calculatedSize = (screenWidth / 1440) * baseSize;

  // Ensure the font size stays within the specified bounds
  return calculatedSize.clamp(minSize, maxSize);
}

class HomeSection extends StatefulWidget {
  final List<String> menuItems;
  final List<VoidCallback> onPressedCallbacks;
  final ScrollController scrollController;

  const HomeSection({
    super.key,
    required this.menuItems,
    required this.onPressedCallbacks,
    required this.scrollController,
  });

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  double _scrollIndicatorOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    // Add listener to scroll controller
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // Remove listener when widget is disposed
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    // Calculate opacity based on scroll position
    // Fade out completely by 100 pixels of scrolling
    final double opacity = 1.0 - (widget.scrollController.offset / 100.0);

    // Update state only if opacity has changed
    if (opacity != _scrollIndicatorOpacity && opacity >= 0) {
      setState(() {
        _scrollIndicatorOpacity = opacity.clamp(0.0, 1.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.lightTheme.colorScheme.onPrimary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // App bar at the top
          AppBar(
              menuItems: widget.menuItems,
              onPressedCallbacks: widget.onPressedCallbacks),
          // Main content
          LayoutBuilder(builder: (context, constraints) {
            // Mobile layout
            if (constraints.maxWidth < 600) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 60.0, left: 20.0, right: 20.0),
                    child: MobileHomePageTitleSection(),
                  ),
                  HomePageImageSection(),
                  // Scroll indicator with fade effect - only on mobile
                  AnimatedOpacity(
                    opacity: _scrollIndicatorOpacity,
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        Text(
                          'Scroll down to learn more',
                          style: TextStyle(
                            fontSize: getResponsiveFontSize(
                              context,
                              baseSize: 24,
                              minSize: 18,
                              maxSize: 24,
                            ),
                            fontWeight: FontWeight.w300,
                            height: 1.2,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 40,
                          color: Colors.grey.shade800,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            // Desktop/tablet layout - without scroll indicator
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, left: 40.0),
                  child: HomePageTitleSection(),
                ),
                HomePageImageSection(),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    super.key,
    required this.menuItems,
    required this.onPressedCallbacks,
  });

  final List<String> menuItems;
  final List<VoidCallback> onPressedCallbacks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
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
    );
  }
}

// Mobile-specific title section
class MobileHomePageTitleSection extends StatelessWidget {
  const MobileHomePageTitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'look',
          style: TextStyle(
            fontSize: getResponsiveFontSize(
              context,
              baseSize: 72,
              minSize: 62,
              maxSize: 72,
            ),
            fontWeight: FontWeight.w700,
            height: 1.1,
            fontFamily: 'Martina',
            color: AppTheme.lightTheme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 40),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Fashion tailored ',
            style: TextStyle(
              fontFamily: 'Museum',
              fontSize: getResponsiveFontSize(
                context,
                baseSize: 42,
                minSize: 32,
                maxSize: 42,
              ),
              height: 1.1,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'uniquely',
                style: TextStyle(),
              ),
              TextSpan(
                text: ' to you',
                style: TextStyle(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Find clothing tailored to you instantly with our AI-powered App that learns from your style.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getResponsiveFontSize(
              context,
              baseSize: 26,
              minSize: 22,
              maxSize: 26,
            ),
            fontWeight: FontWeight.w300,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon: SizedBox(
                  height: 60,
                  width: 140,
                  child: SvgPicture.asset(
                      'assets/icons/Download_on_the_app_store.svg'),
                )),
            const SizedBox(width: 10),
            IconButton(
                onPressed: () {},
                icon: SizedBox(
                  height: 45,
                  child: Image.asset('assets/icons/get_it_on_google_play.png'),
                )),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// Keep the original HomePageTitleSection for desktop/tablet
class HomePageTitleSection extends StatelessWidget {
  const HomePageTitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width > 1200
          ? MediaQuery.of(context).size.width * 0.4
          : 600,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Fashion tailored ',
              style: TextStyle(
                fontFamily: 'Museum',
                fontSize: getResponsiveFontSize(
                  context,
                  baseSize: 42,
                  minSize: 40,
                  maxSize: 48,
                ),
                height: 1.1,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'uniquely',
                  style: TextStyle(),
                ),
                TextSpan(
                  text: ' to you',
                  style: TextStyle(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Find clothing tailored to you instantly with our AI-powered App that learns from your style.',
            style: TextStyle(
              fontSize: getResponsiveFontSize(
                context,
                baseSize: 28,
                minSize: 24,
                maxSize: 32,
              ),
              fontWeight: FontWeight.w300,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: SizedBox(
                    height: 70,
                    width: 160,
                    child: SvgPicture.asset(
                        'assets/icons/Download_on_the_app_store.svg'),
                  )),
              const SizedBox(width: 20),
              IconButton(
                  onPressed: () {},
                  icon: SizedBox(
                    height: 53,
                    child:
                        Image.asset('assets/icons/get_it_on_google_play.png'),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class HomePageImageSection extends StatelessWidget {
  const HomePageImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Mobile-specific adjustments - explicitly return empty container without loading any image
    if (MediaQuery.of(context).size.width < 600) {
      return const SizedBox.shrink(); // More efficient than Container()
    }

    // Keep original behavior for desktop/tablet
    return Container(
      constraints: BoxConstraints(
        minHeight: 500,
        maxHeight: 750,
      ),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Image.asset(
            'assets/images/homepage_image_row.png',
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerLeft,
          )),
    );
  }
}
