import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';
import 'package:website/utils/screen_utils.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.lightTheme.colorScheme.primary,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 1200,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'How It Works',
                  style: AppTheme.lightTheme.textTheme.howItWorkTitle(context),
                ),
                const SizedBox(height: 100),
                Onboarding(),
                if (MediaQuery.of(context).size.height < 700)
                  const SizedBox(height: 40),
                Swipe(),
                if (MediaQuery.of(context).size.height < 700)
                  const SizedBox(height: 40),
                Shop(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Onboarding extends StatelessWidget {
  const Onboarding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getFullScreenSectionHeight(context) * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Step 1: Personalize',
                        style: AppTheme.lightTheme.textTheme
                            .howItWorkStep(context),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Take a quick quiz to let us know your style and preferences 💫',
                        style: AppTheme.lightTheme.textTheme
                            .howItWorkExplanation(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: getFullScreenSectionHeight(context) * 0.7,
                      ),
                      child: Image.asset(
                        'assets/images/onboarding_example.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Swipe extends StatelessWidget {
  const Swipe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getFullScreenSectionHeight(context) * 0.7,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 60,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: getFullScreenSectionHeight(context) * 0.7,
                ),
                child: Image.asset(
                  'assets/images/swipe_example.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step 2: Discover',
                    style: AppTheme.lightTheme.textTheme.howItWorkStep(context),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Like what you see? ',
                    style: AppTheme.lightTheme.textTheme
                        .howItWorkExplanation(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Swipe right to like 💚',
                    style: AppTheme.lightTheme.textTheme
                        .howItWorkExplanation(context),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Not your style?',
                    style: AppTheme.lightTheme.textTheme
                        .howItWorkExplanation(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Swipe left to pass ❌',
                    style: AppTheme.lightTheme.textTheme
                        .howItWorkExplanation(context),
                  ),
                  if (MediaQuery.of(context).size.width > 1000)
                    const SizedBox(height: 60),
                  if (MediaQuery.of(context).size.width > 1000 &&
                      MediaQuery.of(context).size.height > 700)
                    Text(
                      'Our Machine Learning algorithm will learn from your style and tailor recommendations to your tastes.',
                      style: AppTheme.lightTheme.textTheme
                          .howItWorkExplanation(context)
                          .copyWith(fontFamily: 'Satoshi'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Shop extends StatelessWidget {
  const Shop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getFullScreenSectionHeight(context) * 0.7,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 100,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step 3: Shop',
                    style: AppTheme.lightTheme.textTheme.howItWorkStep(context),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Found something you fancy? 😍',
                    style: AppTheme.lightTheme.textTheme
                        .howItWorkExplanation(context),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Swipe up to favorite or order it via our direct checkout!',
                    style: AppTheme.lightTheme.textTheme
                        .howItWorkExplanation(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 2,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: getFullScreenSectionHeight(context) * 0.7,
                ),
                child: Image.asset(
                  'assets/images/favorite&checkout.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
