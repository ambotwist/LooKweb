import 'package:flutter/material.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 800,
              child: Column(
                children: [
                  _buildFaqItem(context, 'What is LooK?',
                      'LooK is a revolutionary platform that helps you...'),
                  _buildFaqItem(context, 'How much does it cost?',
                      'We offer various pricing plans starting from free...'),
                  _buildFaqItem(context, 'Is my data secure?',
                      'Yes, we use industry-standard encryption and security practices...'),
                  _buildFaqItem(context, 'How do I get started?',
                      'Simply sign up for an account and follow our quick setup guide...'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
