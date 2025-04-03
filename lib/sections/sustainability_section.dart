import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';

class SustainabilitySection extends StatelessWidget {
  const SustainabilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 1000;
    
    return Container(
      width: double.infinity,
      color: Colors.white.withOpacity(0.85),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 80.0,
          horizontal: isMobile ? 20.0 : 60.0,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 1200,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Sustainability Mission',
                  style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 40),
                isMobile 
                    ? _buildMobileContent(context)
                    : _buildDesktopContent(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildCommitmentSection(context),
        ),
        const SizedBox(width: 30),
        Expanded(
          flex: 1,
          child: _buildBrandSelectionSection(context),
        ),
        const SizedBox(width: 30),
        Expanded(
          flex: 1,
          child: _buildTransparencySection(context),
        ),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCommitmentSection(context),
        const SizedBox(height: 50),
        _buildBrandSelectionSection(context),
        const SizedBox(height: 50),
        _buildTransparencySection(context),
      ],
    );
  }

  Widget _buildCommitmentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Commitment',
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Look is committed to transforming how fashion works. We believe that style should never come at the expense of our planet or its people.',
          style: AppTheme.lightTheme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 15),
        Text(
          "By embracing sustainable fashion, we're building a future where looking good and doing good go hand in hand. Our platform connects conscious consumers with brands that share these values.",
          style: AppTheme.lightTheme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 15),
        Text(
          'Every purchase through Look is a step toward a more sustainable fashion industry.',
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBrandSelectionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Brand Selection Criteria',
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _buildCriterionItem(
          context, 
          'Ethical Sourcing', 
          'Materials are sourced responsibly without harm to ecosystems or communities.',
        ),
        const SizedBox(height: 15),
        _buildCriterionItem(
          context, 
          'Fair Labor', 
          'Workers receive fair wages and work in safe, dignified conditions throughout the supply chain.',
        ),
        const SizedBox(height: 15),
        _buildCriterionItem(
          context, 
          'Environmental Impact', 
          'Production processes minimize waste, water usage, and carbon footprint.',
        ),
        const SizedBox(height: 15),
        _buildCriterionItem(
          context, 
          'Longevity & Quality', 
          'Products are designed to last, reducing the cycle of fast fashion waste.',
        ),
      ],
    );
  }

  Widget _buildCriterionItem(BuildContext context, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildTransparencySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Transparency Pledge',
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'We believe in complete transparency about how our platform operates:',
          style: AppTheme.lightTheme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 15),
        Text(
          '• We regularly audit our brand partners against our sustainability criteria',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        Text(
          '• Our sustainability ratings are backed by third-party certifications',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        Text(
          '• We publish annual impact reports tracking our collective progress',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        Text(
          "• We're committed to continuous improvement in our own practices",
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Text(
          "Together with our users and brand partners, we're building a fashion ecosystem that values people and planet as much as style.",
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
} 