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

class HomeSection extends StatelessWidget {
  final List<String> menuItems;
  final List<VoidCallback> onPressedCallbacks;

  const HomeSection({
    super.key,
    required this.menuItems,
    required this.onPressedCallbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: AppTheme.lightTheme.colorScheme.onPrimary,
      child: Column(
        children: [
          // App bar at the top
          SizedBox(
            height: 80,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // For smaller screens
                if (constraints.maxWidth < 800) {
                  return SmallAppBar(
                      menuItems: menuItems,
                      onPressedCallbacks: onPressedCallbacks);
                }

                // For larger screens
                return BigAppBar(
                    menuItems: menuItems,
                    onPressedCallbacks: onPressedCallbacks);
              },
            ),
          ),
          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: HomePageTitleSection(),
                  ),
                  HomePageImageSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageTitleSection extends StatelessWidget {
  const HomePageTitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width > 600
              ? 600
              : MediaQuery.of(context).size.width * 0.9,
          child: RichText(
            text: TextSpan(
              text: 'Fashion tailored ',
              style: TextStyle(
                fontFamily: 'Museum',
                fontSize: getResponsiveFontSize(
                  context,
                  baseSize: 48,
                  minSize: 32,
                  maxSize: 56,
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
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width > 600
              ? 600
              : MediaQuery.of(context).size.width * 0.9,
          child: Text(
            'Find clothing tailored to you instantly with our AI-powered App that learns from your style.',
            style: TextStyle(
              fontSize: getResponsiveFontSize(
                context,
                baseSize: 26,
                minSize: 18,
                maxSize: 32,
              ),
              fontWeight: FontWeight.w300,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width > 400 ? 160 : 120,
                    child: SvgPicture.asset(
                        'assets/icons/Download_on_the_app_store.svg'),
                  )),
              const SizedBox(width: 20),
              IconButton(
                  onPressed: () {},
                  icon: SizedBox(
                    height: MediaQuery.of(context).size.width > 400 ? 70 : 50,
                    child:
                        Image.asset('assets/icons/get_it_on_google_play.png'),
                  )),
            ],
          ),
        )
      ],
    );
  }
}

class HomePageImageSection extends StatelessWidget {
  const HomePageImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.of(context).size.width > 900
          ? MediaQuery.of(context).size.height > 700
              ? Image.asset(
                  'assets/images/homepage_image_row.png',
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.centerLeft,
                )
              : const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: MediaQuery.of(context).size.width > 500
                  ? MediaQuery.of(context).size.height > 700
                      ? Image.asset(
                          'assets/images/homepage_image_small.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        )
                      : const SizedBox.shrink()
                  : MediaQuery.of(context).size.height > 800
                      ? Image.asset(
                          'assets/images/homepage_image_tiny.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        )
                      : const SizedBox.shrink(),
            ),
    );
  }
}
