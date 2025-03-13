import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';
import 'package:website/utils/screen_utils.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.lightTheme.colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Contact Us',
              style:
                  Theme.of(context).textTheme.responsiveHeadlineLarge(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 600,
              ),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Message',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                        ),
                        child: const Text('Send Message'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 40,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: [
                _buildContactInfo(
                    context, Icons.email, 'Email', 'contact@look.com'),
                _buildContactInfo(
                    context, Icons.phone, 'Phone', '+1 (123) 456-7890'),
                _buildContactInfo(context, Icons.location_on, 'Address',
                    '123 LooK Street, City'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(
      BuildContext context, IconData icon, String title, String detail) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          detail,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
