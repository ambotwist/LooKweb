import 'package:flutter/material.dart';
import 'package:website/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
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
              ],
            ),
          ),
          const Footer(),
        ],
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

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.lightTheme.colorScheme.primary,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
      child: Column(
        children: [
          // Logo and social media row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App logo section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'look',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Martina',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'AI-Powered Fashion Discovery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Download our app',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse('https://apps.apple.com/app/lookapp'));
                        },
                        child: SizedBox(
                          height: 40,
                          child: SvgPicture.asset(
                            'assets/icons/Download_on_the_app_store.svg',
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.lookapp'));
                        },
                        child: SizedBox(
                          height: 40,
                          child: Image.asset(
                            'assets/icons/get_it_on_google_play.png',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Links section on larger screens
              if (MediaQuery.of(context).size.width >= 768)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterLinkColumn(
                      'Navigation',
                      ['Home', 'How It Works', 'Features', 'FAQ', 'Contact Us'],
                    ),
                    const SizedBox(width: 60),
                    _buildFooterLinkColumn(
                      'Legal',
                      ['Terms & Conditions', 'Privacy Policy', 'Cookie Policy'],
                    ),
                    const SizedBox(width: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildContactItem(
                          Icons.email_outlined,
                          'contact@lookapp.co.uk',
                          'mailto:contact@lookapp.co.uk',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _buildSocialIcon(Icons.facebook, 'https://facebook.com'),
                            const SizedBox(width: 15),
                            _buildSocialIcon(Icons.abc, 'https://x.com'), // Using 'X' icon
                            const SizedBox(width: 15),
                            _buildSocialIcon(Icons.photo_camera, 'https://instagram.com'), // Using camera icon for Instagram
                            const SizedBox(width: 15),
                            _buildSocialIcon(Icons.music_note, 'https://tiktok.com'), // Using music note icon for TikTok
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
          
          // Footer links for mobile screens
          if (MediaQuery.of(context).size.width < 768) ...[
            const SizedBox(height: 30),
            Column(
              children: [
                _buildAccordionMenu('Navigation', ['Home', 'How It Works', 'Features', 'FAQ', 'Contact Us']),
                _buildAccordionMenu('Legal', ['Terms & Conditions', 'Privacy Policy', 'Cookie Policy']),
                const SizedBox(height: 15),
                Column(
                  children: [
                    Text(
                      'Contact',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildContactItem(
                      Icons.email_outlined,
                      'contact@lookapp.co.uk',
                      'mailto:contact@lookapp.co.uk',
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialIcon(Icons.facebook, 'https://facebook.com'),
                        const SizedBox(width: 15),
                        _buildSocialIcon(Icons.abc, 'https://x.com'),
                        const SizedBox(width: 15),
                        _buildSocialIcon(Icons.photo_camera, 'https://instagram.com'), // Using camera icon for Instagram
                        const SizedBox(width: 15),
                        _buildSocialIcon(Icons.music_note, 'https://tiktok.com'), // Using music note icon for TikTok
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
          
          const SizedBox(height: 40),
          Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
          const SizedBox(height: 20),
          
          // Copyright
          Text(
            '© ${DateTime.now().year} LooK App. All rights reserved.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildFooterLinkColumn(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () {},
            child: Text(
              link,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ),
        )).toList(),
      ],
    );
  }
  
  Widget _buildAccordionMenu(String title, List<String> items) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        children: items.map((item) => 
          ListTile(
            dense: true,
            title: Text(
              item,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            onTap: () {},
          )
        ).toList(),
      ),
    );
  }
  
  Widget _buildContactItem(IconData icon, String text, String url) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
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
