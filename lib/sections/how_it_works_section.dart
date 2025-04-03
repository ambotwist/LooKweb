import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';
import 'package:website/utils/screen_utils.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/green-leaves-pattern-illustration.jpg'),
          fit: BoxFit.cover,
          repeat: ImageRepeat.repeatY,
        ),
      ),
      child: Container(
        width: double.infinity,
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 1200,
            ),
            child: MediaQuery.of(context).size.width > 700
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60.0),
                    child: Column(
                      children: [
                        Text(
                          'How It Works',
                          style: AppTheme.lightTheme.textTheme.howItWorkTitle(context),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            'Our Machine Learning algorithm will learn from your style and tailor recommendations to your tastes.',
                            style: TextStyle(
                              color: AppTheme.lightTheme.colorScheme.onPrimary,
                              fontSize: getResponsiveFontSize(
                                context,
                                baseSize: 30,
                                minSize: 22,
                                maxSize: 30,
                              ),
                              fontWeight: FontWeight.w200,
                              fontFamily: 'Museum',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 80),
                        const StepRow(
                          stepNumber: 1,
                          stepText: 'Personalize',
                          stepExplanation:
                              'Take a quick quiz to let us know your style and preferences 💫',
                          stepImagePath: 'assets/images/onboarding_example.png',
                        ),
                        const SizedBox(height: 60),
                        const StepRow(
                          stepNumber: 2,
                          stepText: 'Discover',
                          stepExplanation:
                              'Like what you see?\nSwipe right to like 💚\n\nNot your style?\nSwipe left to pass ❌',
                          stepImagePath: 'assets/images/swipe_example.png',
                        ),
                        const SizedBox(height: 60),
                        const StepRow(
                          stepNumber: 3,
                          stepText: 'Shop',
                          stepExplanation:
                              'Found something you fancy? 😍\nSwipe up to favorite or order it via our direct checkout!',
                          stepImagePath: 'assets/images/favorite&checkout.png',
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Column(
                      children: [
                        Text(
                          'How It Works',
                          style: AppTheme.lightTheme.textTheme.howItWorkTitle(context),
                        ),
                        const SizedBox(height: 60),
                        const MobileOnboarding(),
                        _mobileDivider(),
                        const MobileSwipe(),
                        _mobileDivider(),
                        const MobileShop(),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Padding _mobileDivider() {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                  child: Divider(color: AppTheme.lightTheme.colorScheme.onPrimary),
                );
  }
}

class MobileOnboarding extends StatelessWidget {
  const MobileOnboarding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Step 1: Personalize',
              style: AppTheme.lightTheme.textTheme.howItWorkStep(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Take a quick quiz to let us know your style and preferences 💫',
              style:
                  AppTheme.lightTheme.textTheme.howItWorkExplanation(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          constraints: BoxConstraints(
            maxHeight: 400,
          ),
          child: Image.asset(
            'assets/images/onboarding_example.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class MobileSwipe extends StatelessWidget {
  const MobileSwipe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Step 2: Discover',
              style: AppTheme.lightTheme.textTheme.howItWorkStep(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Like what you see?',
              style: AppTheme.lightTheme.textTheme
                  .howItWorkExplanation(context)
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Swipe right to like 💚',
              style:
                  AppTheme.lightTheme.textTheme.howItWorkExplanation(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Not your style?',
              style: AppTheme.lightTheme.textTheme
                  .howItWorkExplanation(context)
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Swipe left to pass ❌',
              style:
                  AppTheme.lightTheme.textTheme.howItWorkExplanation(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          constraints: BoxConstraints(
            maxHeight: 400,
          ),
          child: Image.asset(
            'assets/images/swipe_example.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class MobileShop extends StatelessWidget {
  const MobileShop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Step 3: Shop',
              style: AppTheme.lightTheme.textTheme.howItWorkStep(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Found something you fancy? 😍',
              style:
                  AppTheme.lightTheme.textTheme.howItWorkExplanation(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Swipe up to favorite or order it via our direct checkout!',
              style:
                  AppTheme.lightTheme.textTheme.howItWorkExplanation(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          constraints: BoxConstraints(
            maxHeight: 400,
          ),
          child: Image.asset(
            'assets/images/favorite&checkout.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class StepRow extends StatelessWidget {
  final int stepNumber;
  final String stepText;
  final String stepExplanation;
  final String stepImagePath;

  const StepRow({
    super.key,
    required this.stepNumber,
    required this.stepText,
    required this.stepExplanation,
    required this.stepImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        
        return Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: stepNumber % 2 != 0 
            ? [
              _explanationSection(context, stepNumber, stepText, stepExplanation),
              const SizedBox(width: 40),
              _imageSection(context, stepImagePath),
            ]
            : [
              _imageSection(context, stepImagePath),
              const SizedBox(width: 40),
              _explanationSection(context, stepNumber, stepText, stepExplanation),
            ],
          ),
        );
      },
    );
  }

  Container _explanationSection(BuildContext context, int stepNumber,
      String stepText, String stepExplanation) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      constraints: BoxConstraints(
        maxWidth: 350,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$stepNumber: $stepText',
            style: AppTheme.lightTheme.textTheme.howItWorkStep(context),
          ),
          const SizedBox(height: 20),
          Text(
            stepExplanation,
            style: AppTheme.lightTheme.textTheme.howItWorkExplanation(context),
          ),
        ],
      ),
    );
  }

  Container _imageSection(BuildContext context, String imagePath) {
    return Container(
              width: MediaQuery.of(context).size.width * 0.5,
              constraints: BoxConstraints(
                maxWidth: 650,
                maxHeight: 650,
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 500,
        maxHeight: 750,
      ),
      child: SizedBox(
        height: getFullScreenSectionHeight(context) * 0.7,
        child: Padding(
          padding: MediaQuery.of(context).size.width > 1000
              ? const EdgeInsets.only(
                  right: 100,
                )
              : MediaQuery.of(context).size.width > 800
                  ? const EdgeInsets.only(
                      right: 60,
                    )
                  : const EdgeInsets.only(
                      right: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 500,
                    maxHeight: 750,
                  ),
                  child: Image.asset(
                    'assets/images/swipe_example.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Spacer(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2: Discover',
                      style:
                          AppTheme.lightTheme.textTheme.howItWorkStep(context),
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
                        MediaQuery.of(context).size.height > 800)
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 500,
        maxHeight: 750,
      ),
      child: SizedBox(
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
                      '3: Shop',
                      style:
                          AppTheme.lightTheme.textTheme.howItWorkStep(context),
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
                    minHeight: 500,
                    maxHeight: 750,
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
      ),
    );
  }
}
