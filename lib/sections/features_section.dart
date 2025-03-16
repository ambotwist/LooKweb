import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 60.0,
        horizontal: 60.0,
      ),
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
          Align(
            alignment: Alignment.topCenter,
            child: MediaQuery.of(context).size.width > 700
                ? ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 1200,
                  ),
                  child: Image.asset(
                      'assets/images/smartsearch_example.png',
                      fit: BoxFit.contain,
                    ),
                )
                : MediaQuery.of(context).size.width > 500
                    ? ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 800,
                      ),
                      child: Image.asset(
                          'assets/images/smartsearch_example_small.png',
                          fit: BoxFit.contain,
                        ),
                    )
                    : Image.asset(
                        'assets/images/smartsearch_example_tiny.png',
                        fit: BoxFit.contain,
                      ),
          ),
        ],
      ),
    );
  }
}
