import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final Widget tiny;
  final Widget largeTablet;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    required this.tiny,
    required this.largeTablet,
  }) : super(key: key);

  static final int tinyHeightLimit = 100;
  static final int tinyLimit = 270;
  static final int mobileLimit = 550;
  static final int tabletLimit = 800;
  static final int largeTabletLimit = 1100;

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later

  static bool isTinyLimit(BuildContext context) =>
      MediaQuery.of(context).size.width < tinyLimit;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletLimit;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= tabletLimit;

  static bool isLargeTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < largeTabletLimit &&
      MediaQuery.of(context).size.width >= tabletLimit;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeTabletLimit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < tinyLimit ||
            constraints.maxHeight < tinyHeightLimit) {
          return tiny;
        }
        if (constraints.maxWidth < mobileLimit) {
          return mobile;
        }
        if (constraints.maxWidth < tabletLimit) {
          return tablet;
        }
        if (constraints.maxWidth < largeTabletLimit) {
          return largeTablet;
        } else {
          return desktop;
        }
      },
    );
  }
}
