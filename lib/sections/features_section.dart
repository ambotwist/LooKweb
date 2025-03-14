import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';
import 'package:website/utils/screen_utils.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height > 700
            ? getFullScreenSectionHeight(context)
            : getFullScreenSectionHeight(context) * 1.1,
        width: MediaQuery.of(context).size.width,
        color: AppTheme.lightTheme.colorScheme.onPrimary,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, left: 60, right: 60, bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Looking for something specific?\nTry our ',
                  style: Theme.of(context)
                      .textTheme
                      .responsiveHeadlineMedium(context)
                      .copyWith(
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w900,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'SmartSearch',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 0, 85),
                      ),
                    ),
                    TextSpan(
                      text: '.',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 700
                    ? 40
                    : MediaQuery.of(context).size.height * 0.075,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: MediaQuery.of(context).size.width > 700
                      ? Image.asset(
                          'assets/images/smartsearch_example.png',
                          fit: BoxFit.contain,
                        )
                      : MediaQuery.of(context).size.width > 500
                          ? Image.asset(
                              'assets/images/smartsearch_example_small.png',
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              'assets/images/smartsearch_example_tiny.png',
                              fit: BoxFit.contain,
                            ),
                ),
              ),
            ],
          ),
        ));
  }
}
