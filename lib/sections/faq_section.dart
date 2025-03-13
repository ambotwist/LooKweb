import 'package:flutter/material.dart';
import 'package:website/utils/screen_utils.dart';
import 'package:website/theme/app_theme.dart';

class FAQSection extends StatefulWidget {
  const FAQSection({super.key});

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  // Controllers for each expansion tile
  final List<ExpansionTileController> _controllers = List.generate(
    4, // Number of FAQ items
    (_) => ExpansionTileController(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context)
                  .textTheme
                  .responsiveHeadlineLarge(context)
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 800,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFaqItem(
                    context,
                    'Are there any fees?',
                    "The app is completely free with no commission fees. The prices listed reflect the store's online prices and all discounts are automatically shown to you and applied at checkout, therefore you know that you're getting the best deal.",
                    0,
                  ),
                  _buildFaqItem(
                    context,
                    'Who ships the items?',
                    "The corresponding store ships the items directly to you so there's no middleman and it ensures the best possible shipping experience.",
                    1,
                  ),
                  _buildFaqItem(
                    context,
                    'Can I return items?',
                    'You can return items to the store you purchased them from, according to the store\'s return policy.',
                    2,
                  ),
                  _buildFaqItem(
                    context,
                    'How long does it take to get my order?',
                    'Items are shipped directly by the store and the delivery time is dependent on the store\'s shipping time. Estimated delivery times are displayed on the product detail page.',
                    3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            FAQContactSection()
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(
      BuildContext context, String question, String answer, int index) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.white,
      ),
      child: ExpansionTile(
        controller: _controllers[index],
        onExpansionChanged: (isExpanded) {
          if (isExpanded) {
            // Collapse all other expansion tiles
            for (int i = 0; i < _controllers.length; i++) {
              if (i != index) {
                _controllers[i].collapse();
              }
            }
          }
        },
        title: Text(
          question,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: getResponsiveFontSize(
                  context,
                  baseSize: 24,
                  minSize: 18,
                  maxSize: 28,
                ),
              ),
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                answer,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: getResponsiveFontSize(
                        context,
                        baseSize: 20,
                        minSize: 16,
                        maxSize: 24,
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FAQContactSection extends StatelessWidget {
  const FAQContactSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Still have questions?",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: getResponsiveFontSize(
                  context,
                  baseSize: 28,
                  minSize: 20,
                  maxSize: 32,
                ),
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Text(
              "Contact Us",
              style: TextStyle(
                fontSize: getResponsiveFontSize(
                  context,
                  baseSize: 24,
                  minSize: 18,
                  maxSize: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
