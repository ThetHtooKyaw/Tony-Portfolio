import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/home/widgets/responsive_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedExperienceCard extends StatefulWidget {
  final int index;
  final Map<String, dynamic> expData;
  const AnimatedExperienceCard({
    super.key,
    required this.index,
    required this.expData,
  });

  @override
  State<AnimatedExperienceCard> createState() => _AnimatedExperienceCardState();
}

class _AnimatedExperienceCardState extends State<AnimatedExperienceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideUpAnimation;
  bool isTextExpanded = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _slideUpAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);

    return VisibilityDetector(
      key: Key('exp-${widget.index}'),
      onVisibilityChanged: (expCard) {
        if (expCard.visibleFraction > 0.3) {
          if (_controller.status == AnimationStatus.dismissed ||
              _controller.status == AnimationStatus.reverse) {
            _controller.forward();
          }
        } else if (expCard.visibleFraction == 0) {
          if (isDesktop) {
            _controller.reset();
          }
          isTextExpanded = false;
        }
      },

      child: FadeTransition(
        opacity: _fadeInAnimation,
        child: SlideTransition(
          position: _slideUpAnimation,
          child: isDesktop
              ? _buildDesktopCard(
                  screenSize: screenSize.width,
                  isHeadlineleft: widget.index % 2 == 0,
                  expData: widget.expData,
                )
              : _buildMobileCard(
                  screenWidth: screenSize.width,
                  expData: widget.expData,
                ),
        ),
      ),
    );
  }

  Widget _buildDesktopCard({
    required double screenSize,
    required bool isHeadlineleft,
    required Map<String, dynamic> expData,
  }) {
    Widget headline = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: isHeadlineleft
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        // Position
        AutoSizeText(
          expData['position'],
          textAlign: isHeadlineleft ? TextAlign.right : TextAlign.left,
          maxFontSize: 30.0,
          minFontSize: 24.0,
          style: TextStyle(
            fontFamily: 'Oswald',
            color: AppColor.white,
            fontSize: screenSize * 0.03,
            height: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        // Company Name
        AutoSizeText(
          expData['company'],
          textAlign: isHeadlineleft ? TextAlign.right : TextAlign.left,
          maxFontSize: 26.0,
          minFontSize: 20.0,
          style: TextStyle(
            fontFamily: 'Open Sans',
            color: AppColor.accent,
            fontSize: screenSize * 0.03,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 8),

        // Year
        AutoSizeText(
          expData['year'],
          maxFontSize: 20.0,
          minFontSize: 16.0,
          style: TextStyle(
            fontFamily: 'Questrial',
            color: AppColor.placeholder,
            fontSize: screenSize * 0.03,
            height: 1.0,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 12),

        // Company Logo
        _buildCompanyLogo(expData),
      ],
    );

    Widget description = SizedBox(
      width: 500,
      child: AutoSizeText(
        expData['desc'],
        textAlign: isHeadlineleft ? TextAlign.left : TextAlign.right,
        maxFontSize: 18.0,
        minFontSize: 14.0,
        style: TextStyle(
          fontFamily: 'Open Sans',
          color: AppColor.white,
          fontSize: screenSize * 0.016,
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 40),
            child: Align(
              alignment: Alignment.topRight,
              child: isHeadlineleft ? headline : description,
            ),
          ),
        ),

        // Right Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: isHeadlineleft ? description : headline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileCard({
    required double screenWidth,
    required Map<String, dynamic> expData,
  }) {
    final isTablet = ResponsiveWidget.isTablet(context);

    return GestureDetector(
      onTap: () => setState(() => isTextExpanded = !isTextExpanded),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppFormat.primaryBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(AppFormat.priamaryPadding),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.shadow.withValues(alpha: 0.2),
              border: Border.all(
                color: AppColor.accent.withValues(alpha: 0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                AppFormat.primaryBorderRadius,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // Company Logo
                    _buildCompanyLogo(expData),
                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Position
                          AutoSizeText(
                            expData['position'],
                            maxFontSize: 20.0,
                            minFontSize: 16.0,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              color: AppColor.white,
                              fontSize: screenWidth * 0.03,
                              height: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Company Name
                          AutoSizeText(
                            expData['company'],
                            maxFontSize: 18.0,
                            minFontSize: 14.0,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              color: AppColor.accent,
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Year
                          AutoSizeText(
                            expData['year'],
                            maxFontSize: 18.0,
                            minFontSize: 14.0,

                            style: TextStyle(
                              fontFamily: 'Questrial',
                              color: AppColor.placeholder,
                              fontSize: screenWidth * 0.03,
                              height: 1.0,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                AutoSizeText(
                  expData['desc'],
                  maxFontSize: 18.0,
                  minFontSize: 14.0,
                  maxLines: isTablet
                      ? isTextExpanded
                            ? 10
                            : 6
                      : isTextExpanded
                      ? 10
                      : 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: AppColor.white,
                    fontSize: screenWidth * 0.02,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyLogo(Map<String, dynamic> expData) {
    return ClipOval(
      child: Container(
        height: 50,
        width: 50,
        color: AppColor.white,
        child: Image.asset(expData['logo'], fit: BoxFit.cover),
      ),
    );
  }
}
