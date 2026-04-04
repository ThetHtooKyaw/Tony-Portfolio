import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/src/home/widgets/responsive_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedCertificateCard extends StatefulWidget {
  final int index;
  final Map<String, String> certificate;
  final bool isRightColumn;
  const AnimatedCertificateCard({
    super.key,
    required this.index,
    required this.certificate,
    required this.isRightColumn,
  });

  @override
  State<AnimatedCertificateCard> createState() =>
      _AnimatedCertificateCardState();
}

class _AnimatedCertificateCardState extends State<AnimatedCertificateCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
      key: ValueKey('certificate-${widget.index}'),
      onVisibilityChanged: (certiCard) {
        if (certiCard.visibleFraction > 0.1) {
          if (_controller.status == AnimationStatus.dismissed ||
              _controller.status == AnimationStatus.reverse) {
            _controller.forward();
          }
        }
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Transform.translate(
            offset: Offset(0, widget.isRightColumn ? 150 : 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColor.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: isDesktop
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          widget.certificate['image']!,
                          height: (screenSize.width * 0.225).clamp(300, 450),
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                      // const SizedBox(height: 20),
                      const Spacer(),

                      AutoSizeText(
                        widget.certificate['title']!,
                        maxFontSize: 30,
                        minFontSize: 16,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColor.white,
                          fontFamily: 'Oswald',
                          fontSize: screenSize.width * 0.03,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
