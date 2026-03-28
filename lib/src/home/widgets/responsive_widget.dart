import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? smallMobile;
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveWidget({
    super.key,
    this.smallMobile,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isSmallMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= 400;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width > 400 &&
      MediaQuery.sizeOf(context).width <= 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width > 600 &&
      MediaQuery.sizeOf(context).width < 840;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 840;

  @override
  Widget build(BuildContext context) {
    if (isSmallMobile(context) && smallMobile != null) {
      return smallMobile!;
    } else if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context) && tablet != null) {
      return tablet!;
    } else {
      return desktop;
    }
  }
}
