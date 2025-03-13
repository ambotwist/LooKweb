import 'package:flutter/material.dart';

/// Returns the height for a full-screen section
double getFullScreenSectionHeight(BuildContext context) {
  // Get the full screen height
  return MediaQuery.of(context).size.height;
}

/// Calculates a responsive font size based on screen width with min and max constraints
double getResponsiveFontSize(
  BuildContext context, {
  required double baseSize,
  required double minSize,
  required double maxSize,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  // Calculate responsive size (baseSize is for 1440px width)
  final responsiveSize = baseSize * (screenWidth / 1440);

  // Constrain the size between minSize and maxSize
  return responsiveSize.clamp(minSize, maxSize);
}
