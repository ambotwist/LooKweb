import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/utils/screen_utils.dart';
import 'package:website/theme/app_theme.dart';

class ForBrandsSection extends StatefulWidget {
  const ForBrandsSection({super.key});

  @override
  State<ForBrandsSection> createState() => _ForBrandsSectionState();
}

class _ForBrandsSectionState extends State<ForBrandsSection> {
  // Controllers for the brand FAQ expansion tiles
  final List<ExpansionTileController> _controllers = List.generate(
    3, // Number of brand FAQ items
    (_) => ExpansionTileController(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'For Brands',
              style: Theme.of(context)
                  .textTheme
                  .responsiveHeadlineLarge(context)
                  .copyWith(color: Theme.of(context).colorScheme.primary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeading(context, 'Why Partner With look?'),
                  const SizedBox(height: 20),
                  _buildFeatureItem(
                    context, 
                    'Expanded Customer Reach', 
                    'Gain access to our growing user base of fashion-forward shoppers who are actively looking for new products.'
                  ),
                  const SizedBox(height: 20),
                  _buildFeatureItem(
                    context, 
                    'AI-Powered Discovery', 
                    'Our algorithms match your products with users most likely to purchase them, increasing conversion rates.'
                  ),
                  const SizedBox(height: 20),
                  _buildFeatureItem(
                    context, 
                    'Real-Time Catalog Updates', 
                    'Changes to your inventory, pricing, and promotions are reflected instantly on our platform.'
                  ),
                  
                  // const SizedBox(height: 40),
                  // _buildSectionHeading(context, 'Simple Integration'),
                  // const SizedBox(height: 20),
                  // _buildFeatureItem(
                  //   context, 
                  //   'API-Based Integration', 
                  //   'We work with stores that provide API access to their catalog, ensuring seamless product synchronization.'
                  // ),
                  // const SizedBox(height: 20),
                  // _buildFeatureItem(
                  //   context, 
                  //   'Minimal Setup Required', 
                  //   'Our team handles most of the integration work, minimizing the effort required from your developers.'
                  // ),
                  
                  // const SizedBox(height: 40),
                  // _buildSectionHeading(context, 'Business Model'),
                  // const SizedBox(height: 20),
                  // _buildFeatureItem(
                  //   context, 
                  //   'Transparent Commission', 
                  //   'Simple 5% commission on sales generated through our platform - no hidden fees.'
                  // ),
                  // const SizedBox(height: 20),
                  // _buildFeatureItem(
                  //   context, 
                  //   'You Handle Transactions', 
                  //   'Customers purchase directly through your existing payment system - we simply direct the traffic.'
                  // ),
                  
                  // const SizedBox(height: 60),
                  // _buildBrandFAQSection(context),
                  
                  const SizedBox(height: 60),
                  _buildCallToAction(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeading(BuildContext context, String text) {
    final RegExp lookPattern = RegExp(r'\blook\b', caseSensitive: false);
    final List<InlineSpan> spans = [];
    
    int lastMatchEnd = 0;
    for (final match in lookPattern.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: getResponsiveFontSize(
                context,
                baseSize: 28,
                minSize: 22,
                maxSize: 28,
              ),
            ),
          ),
        );
      }
      
      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontFamily: 'Martina',
            fontSize: getResponsiveFontSize(
              context,
              baseSize: 28,
              minSize: 22,
              maxSize: 28,
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
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: getResponsiveFontSize(
              context,
              baseSize: 28,
              minSize: 22,
              maxSize: 28,
            ),
          ),
        ),
      );
    }
    
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String title, String description) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              fontSize: getResponsiveFontSize(
                context,
                baseSize: 22,
                minSize: 18,
                maxSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black87,
              fontSize: getResponsiveFontSize(
                context,
                baseSize: 18,
                minSize: 16,
                maxSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandFAQSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading(context, 'FAQ for Brands'),
        const SizedBox(height: 20),
        _buildFaqItem(
          context,
          'What types of brands can partner with look?',
          _buildRichText(context, 'We partner with fashion retailers of all sizes, from boutique shops to major brands. The main requirement is having an API that allows us to access your product catalog.'),
          0,
        ),
        _buildFaqItem(
          context,
          'How long does integration take?',
          _buildRichText(context, 'For most brands with standard API setups, integration can be completed within 1-2 weeks. Our team works closely with yours to ensure a smooth process.'),
          1,
        ),
        _buildFaqItem(
          context,
          'Can we control which products appear on look?',
          _buildRichText(context, 'Yes, you can specify which collections or products to feature on our platform, and you can update these preferences at any time through our partner dashboard.'),
          2,
        ),
      ],
    );
  }

  Widget _buildFaqItem(
      BuildContext context, String question, Widget answer, int index) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Theme.of(context).colorScheme.primary,
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
            color: Theme.of(context).colorScheme.primary,
            fontSize: getResponsiveFontSize(
              context,
              baseSize: 20,
              minSize: 16,
              maxSize: 20,
            ),
          ),
        ),
        iconColor: Theme.of(context).colorScheme.primary,
        collapsedIconColor: Theme.of(context).colorScheme.primary,
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
          color: Colors.black87,
          fontSize: getResponsiveFontSize(
            context,
            baseSize: 18,
            minSize: 16,
            maxSize: 18,
          ),
        ) ?? const TextStyle(
          color: Colors.black87,
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
            style: style,
          ),
        );
      }
      
      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: style.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Martina',
            fontSize: getResponsiveFontSize(
              context,
              baseSize: 18,
              minSize: 16,
              maxSize: 18,
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
          style: style,
        ),
      );
    }
    
    return spans;
  }

  Widget _buildCallToAction(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Interested in partnering with us?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: getResponsiveFontSize(
                context,
                baseSize: 28,
                minSize: 22,
                maxSize: 28,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Contact us at partners@lookapp.co.uk',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontSize: getResponsiveFontSize(
                context,
                baseSize: 20,
                minSize: 16,
                maxSize: 20,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              launchUrl(Uri.parse('mailto:partners@lookapp.co.uk'));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(
              'Partner With Us',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveFontSize(
                  context,
                  baseSize: 18,
                  minSize: 16,
                  maxSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 