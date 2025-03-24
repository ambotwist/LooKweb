import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

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
            // TextFields(),
            const SizedBox(height: 40),
            Wrap(
              spacing: 40,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: [
                _buildClickableContactInfo(
                  context,
                  Icons.email,
                  'Email',
                  'contact@lookapp.co.uk',
                  'mailto:contact@lookapp.co.uk',
                ),
                _buildClickableContactInfo(
                  context,
                  Icons.phone,
                  'Phone',
                  '+41 76 577 60 38',
                  'tel:+41765776038',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClickableContactInfo(BuildContext context, IconData icon,
      String title, String detail, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

class TextFields extends StatelessWidget {
  const TextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('Send Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
