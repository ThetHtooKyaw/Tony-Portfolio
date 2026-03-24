import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
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
    return VisibilityDetector(
      key: Key('exp-${widget.index}'),
      onVisibilityChanged: (expCard) {
        if (expCard.visibleFraction > 0.3) {
          if (_controller.status == AnimationStatus.dismissed ||
              _controller.status == AnimationStatus.reverse) {
            _controller.forward();
          }
        } else if (expCard.visibleFraction == 0) {
          _controller.reset();
        }
      },

      child: FadeTransition(
        opacity: _fadeInAnimation,
        child: SlideTransition(
          position: _slideUpAnimation,
          child: _buildExperienceRow(
            isHeadlineleft: widget.index % 2 == 0,
            expData: widget.expData,
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceRow({
    required bool isHeadlineleft,
    required Map<String, dynamic> expData,
  }) {
    final screenSize = MediaQuery.sizeOf(context);
    final bool isDesktop = screenSize.width > 700;

    Widget headline = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: isHeadlineleft
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        // Position
        Text(
          expData['position'],
          textAlign: isHeadlineleft ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            fontFamily: 'Oswald',
            color: AppColor.white,
            fontSize: (screenSize.width * 0.02).clamp(24, 30),
            height: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        // Company Name
        Text(
          expData['company'],
          textAlign: isHeadlineleft ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            fontFamily: 'Open Sans',
            color: AppColor.accent,
            fontSize: (screenSize.width * 0.02).clamp(20, 26),
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 8),

        // Year
        Text(
          expData['year'],
          style: TextStyle(
            fontFamily: 'Questrial',
            color: AppColor.placeholder,
            fontSize: (screenSize.width * 0.02).clamp(20, 26),
            height: 1.0,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 12),

        // Company Logo
        ClipOval(
          child: Container(
            height: 50,
            width: 50,
            color: AppColor.white,
            child: Image.asset(expData['logo'], fit: BoxFit.cover),
          ),
        ),
      ],
    );

    Widget description = SizedBox(
      width: 500,
      child: Text(
        expData['desc'],
        textAlign: isHeadlineleft ? TextAlign.left : TextAlign.right,
        style: TextStyle(
          fontFamily: 'Open Sans',
          color: AppColor.white,
          fontSize: (screenSize.width * 0.016).clamp(14, 18),
        ),
      ),
    );

    return isDesktop
        ? Row(
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
          )
        : _buildMobileCard(screenSize.width, expData);
  }

  Widget _buildMobileCard(double screenWidth, Map<String, dynamic> expData) {
    return ClipRRect(
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
            borderRadius: BorderRadius.circular(AppFormat.primaryBorderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  // Company Logo
                  ClipOval(
                    child: Container(
                      height: 50,
                      width: 50,
                      color: AppColor.white,
                      child: Image.asset(expData['logo'], fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Position
                        Text(
                          expData['position'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            color: AppColor.white,
                            fontSize: 20,
                            height: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Company Name
                        Text(
                          expData['company'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            color: AppColor.accent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Year
                        Text(
                          expData['year'],
                          style: TextStyle(
                            fontFamily: 'Questrial',
                            color: AppColor.placeholder,
                            fontSize: 18,
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

              Text(
                expData['desc'],
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  color: AppColor.white,
                  fontSize: (screenWidth * 0.02).clamp(13.0, 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
