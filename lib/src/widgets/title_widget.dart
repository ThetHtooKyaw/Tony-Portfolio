import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Color color;
  const TitleWidget({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isLargeScreen = ResponsiveWidget.isLargeScreen(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen
            ? (screenSize.width * 0.03).clamp(40.0, 80.0)
            : AppFormat.primaryPadding,
      ),
      child: AutoSizeText(
        title,
        maxFontSize: 100,
        minFontSize: 30,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Racing Sans One',
          color: color,
          height: 1,
          fontSize: screenSize.width * 0.1,
        ),
      ),
    );
  }
}

class SubTitleWidget extends StatelessWidget {
  final String subtitle;
  final Color color;
  const SubTitleWidget({
    super.key,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isLargeScreen = ResponsiveWidget.isLargeScreen(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen
            ? (screenSize.width * 0.03).clamp(40.0, 80.0)
            : AppFormat.primaryPadding,
      ),
      child: AutoSizeText(
        subtitle,
        maxFontSize: 20,
        minFontSize: 8,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Questrial',
          color: color,
          fontSize: screenSize.width * 0.03,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
