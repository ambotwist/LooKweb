www.lookapp.co.uk

# LooK - AI-Powered Fashion Discovery

LooK is a modern fashion discovery platform that uses AI to personalize your shopping experience. Think Tinder for Fashion - users swipe on items to fine-tune the AI and get tailored live recommendations.

## Features

- Intuitive swipe interface for fashion discovery
- AI-powered personalization
- Real-time style recommendations
- Direct shopping integration

## Getting Started

This project is built with Flutter. To run it locally:

1. Make sure you have Flutter installed on your machine
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run -d chrome` to start the web app

## Development

This is a Flutter web project. The main application code is in the `lib` directory.

### Project Structure

- `lib/` - Contains the main application code
- `assets/` - Contains images and fonts
- `web/` - Web-specific files
- `test/` - Unit and widget tests

## License

This project is proprietary and confidential. All rights reserved.

# LooK Web App

A modern one-page web application built with Flutter for web.

## Features

- Full-window sections for a modern, immersive experience
- Smooth scrolling between sections
- Responsive design that works on all screen sizes
- Navigation dots for easy section navigation
- Header navigation with menu items

## Project Structure

- `lib/main.dart` - Main application entry point
- `lib/sections/` - Individual full-window sections
  - `home_section.dart` - Welcome/landing section
  - `how_it_works_section.dart` - How It Works section
  - `features_section.dart` - Features showcase section
  - `faq_section.dart` - Frequently Asked Questions section
  - `contact_section.dart` - Contact form and information section
- `lib/widgets/` - Reusable UI components
  - `page_controller_widget.dart` - Controls the full-page scrolling
  - `big_app_bar.dart` - App bar for larger screens
  - `small_app_bar.dart` - App bar for smaller screens
  - `app_bar_drawer.dart` - Drawer for mobile navigation
- `lib/theme/` - App theming

## Getting Started

1. Make sure you have Flutter installed and set up for web development
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run -d chrome` to launch the app in Chrome

## Customization

### Adding a New Section

1. Create a new section file in the `lib/sections/` directory
2. Add the section to the `sections` list in `lib/main.dart`
3. Update the menu items and callbacks in `lib/main.dart`

### Changing the Theme

Modify the `lib/theme/app_theme.dart` file to customize colors, typography, and other theme properties.

## Dependencies

- Flutter SDK
- Material Design

## License

This project is licensed under the MIT License - see the LICENSE file for details.
