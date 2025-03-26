import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedTopic = 'Question';

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

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
            ContactForm(
              formKey: _formKey,
              nameController: _nameController,
              lastNameController: _lastNameController,
              emailController: _emailController,
              messageController: _messageController,
              selectedTopic: _selectedTopic,
              onTopicChanged: (value) {
                setState(() {
                  _selectedTopic = value;
                });
              },
              onSubmit: _submitForm,
            ),
            const SizedBox(height: 40),
            // Wrap(
            //   spacing: 40,
            //   runSpacing: 30,
            //   alignment: WrapAlignment.center,
            //   children: [
            //     _buildClickableContactInfo(
            //       context,
            //       Icons.email,
            //       'Email',
            //       'contact@lookapp.co.uk',
            //       'mailto:contact@lookapp.co.uk',
            //     ),
            //     // _buildClickableContactInfo(
            //     //   context,
            //     //   Icons.phone,
            //     //   'Phone',
            //     //   '+41 76 577 60 38',
            //     //   'tel:+41765776038',
            //     // ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final subject = 'Contact Form: $_selectedTopic';
      final body = '''
Name: ${_nameController.text} ${_lastNameController.text}
Email: ${_emailController.text}
Topic: $_selectedTopic
Message:
${_messageController.text}
''';

      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'contact@lookapp.co.uk',
        query: _encodeQueryParameters({
          'subject': subject,
          'body': body,
          'cc': _emailController.text,
        }),
      );

      _launchUrl(emailUri.toString());
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
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

class ContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final String selectedTopic;
  final Function(String) onTopicChanged;
  final VoidCallback onSubmit;

  const ContactForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.lastNameController,
    required this.emailController,
    required this.messageController,
    required this.selectedTopic,
    required this.onTopicChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name*',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name*',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Topic',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedTopic,
                  items: ['Question', 'Feature Request', 'Bug Report', 'Complaint', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      onTopicChanged(newValue);
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: messageController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Message*',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Send Message'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
