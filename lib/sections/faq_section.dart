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
    6, // Number of FAQ items
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
                    'How does look work?',
                    _buildRichText(context, "look is a gamified fashion shopping app that helps you discover clothes effortlessly. You can swipe through AI-driven recommendations, search for specific styles using natural language (e.g., \"blue top for a semi-formal party\"), and purchase directly from partnered stores."),
                    0,
                  ),
                  _buildFaqItem(
                    context,
                    'How does look recommend products?',
                    _buildRichText(context, "look uses AI to analyze your preferences based on swipes and searches, continuously refining recommendations to match your style. The more you interact with the app, the better it gets at curating your perfect wardrobe."),
                    1,
                  ),
                  _buildFaqItem(
                    context,
                    'Are there any fees?',
                    _buildRichText(context, "The app is completely free with no commission fees. The prices listed reflect the store's online prices and all discounts are automatically shown to you and applied at checkout, therefore you know that you're getting the best deal."),
                    2,
                  ),
                  _buildFaqItem(
                    context,
                    'Who ships the items?',
                    _buildRichText(context, "The corresponding store ships the items directly to you so there's no middleman and it ensures the best possible shipping experience."),
                    3,
                  ),
                  _buildFaqItem(
                    context,
                    'Can I return items?',
                    _buildRichText(context, 'You can return items to the store you purchased them from, according to the store\'s return policy.'),
                    4,
                  ),
                  _buildFaqItem(
                    context,
                    'How long does it take to get my order?',
                    _buildRichText(context, 'Items are shipped directly by the store and the delivery time is dependent on the store\'s shipping time. Estimated delivery times are displayed on the product detail page.'),
                    5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            // FAQContactSection()
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(
      BuildContext context, String question, Widget answer, int index) {
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
        title: RichText(
          text: TextSpan(
            children: _buildRichTextSpans(
              context, 
              question,
              (Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: getResponsiveFontSize(
                  context,
                  baseSize: 24,
                  minSize: 18,
                  maxSize: 24,
                ),
              ) ?? TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              )),
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
              child: answer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRichText(BuildContext context, String text) {
    final bodyStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontSize: getResponsiveFontSize(
            context,
            baseSize: 20,
            minSize: 16,
            maxSize: 20,
          ),
        ) ?? TextStyle(
          color: Colors.white,
          fontSize: 16,
        );
        
    return RichText(
      text: TextSpan(
        children: _buildRichTextSpans(context, text, bodyStyle),
      ),
    );
  }

  List<TextSpan> _buildRichTextSpans(BuildContext context, String text, TextStyle style) {
    final RegExp lookPattern = RegExp(r'\bLooK\b', caseSensitive: false);
    final List<TextSpan> spans = [];
    
    int lastMatchEnd = 0;
    for (final match in lookPattern.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: style.copyWith(
              color: Colors.white,
              fontSize: getResponsiveFontSize(
                context,
                baseSize: 20,
                minSize: 16,
                maxSize: 20,
              ),
            ),
          ),
        );
      }
      
      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: style.copyWith(
            color: Colors.white,
            fontFamily: 'Martina',
            fontSize: getResponsiveFontSize(
              context,
              baseSize: 20,
              minSize: 16,
              maxSize: 20,
            ),
          ),
        ),
      );
      
      lastMatchEnd = match.end;
    }
    
    if (lastMatchEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd),
          style: style.copyWith(
            color: Colors.white,
            fontSize: getResponsiveFontSize(
              context,
              baseSize: 20,
              minSize: 16,
              maxSize: 20,
            ),
          ),
        ),
      );
    }
    
    return spans;
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
            child: TextButton(
              onPressed: () {},
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
      ),
    ],
    );
  }
}
