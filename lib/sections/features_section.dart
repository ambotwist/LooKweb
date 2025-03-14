import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';
import 'package:website/utils/screen_utils.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 60.0),
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
          const SizedBox(height: 40),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 500,
              maxHeight: 750,
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 500,
                maxHeight: 750,
                maxWidth: 1200,
              ),
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
    );
  }
}
