import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';

class AnimatedCertificateCard extends StatefulWidget {
  final int index;
  final Map<String, dynamic> certificate;
  final bool isExpandedMobile;
  final VoidCallback onTapMobile;

  // final bool isRightColumn;
  const AnimatedCertificateCard({
    super.key,
    required this.index,
    required this.certificate,
    required this.isExpandedMobile,
    required this.onTapMobile,
  });

  @override
  State<AnimatedCertificateCard> createState() =>
      _AnimatedCertificateCardState();
}

class _AnimatedCertificateCardState extends State<AnimatedCertificateCard> {
  bool _isHovering = false;

  void _handleSeeMore() {
    if (widget.certificate['detail'] == false) return;

    if (widget.index == 0) {
      context.go(
        '/awards/certificates',
        extra: widget.certificate['certificates'],
      );
    } else if (widget.index == 1) {
      context.go(
        '/awards/certificates',
        extra: widget.certificate['certificates'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isExpanded = isDesktop ? _isHovering : widget.isExpandedMobile;

    Widget largeCard = GestureDetector(
      onTap: _handleSeeMore,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 500,
        width: _isHovering
            ? (screenSize.width * 0.1).clamp(500, 650)
            : (screenSize.width * 0.1).clamp(80, 200),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            // Certificate Image
            _buildImageContainer(650),

            // "See More" Button
            if (widget.certificate['detail'] == true)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(child: _buildButton(screenSize)),
              ),

            // Foreground Overlay
            _buildOverlay(18),

            // Certificate Title
            _isHovering
                ? const SizedBox.shrink()
                : Center(
                    child: RotatedBox(
                      quarterTurns: 5,
                      child: AutoSizeText(
                        widget.certificate['title']!,
                        maxFontSize: 20,
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
                    ),
                  ),
          ],
        ),
      ),
    );

    if (isDesktop) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: largeCard,
      );
    }

    Widget smallCard = GestureDetector(
      onTap: _handleSeeMore,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: isExpanded ? 500 : 150,
        width: screenSize.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            // Certificate Image
            _buildImageContainer(double.infinity),

            // "See More" Button
            if (widget.certificate['detail'] == true)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(child: _buildButton(screenSize)),
              ),

            // Foreground Overlay
            _buildOverlay(20),

            // Certificate Title
            isExpanded
                ? const SizedBox.shrink()
                : Center(
                    child: AutoSizeText(
                      widget.certificate['title']!,
                      maxFontSize: 20,
                      minFontSize: 14,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.white,
                        fontFamily: 'Oswald',
                        fontSize: screenSize.width * 0.03,
                        height: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );

    if (isDesktop) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: largeCard,
      );
    }

    return GestureDetector(onTap: widget.onTapMobile, child: smallCard);
  }

  Widget _buildButton(Size screenSize) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.shadow,
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
          ),
          child: AutoSizeText(
            'See More',
            maxFontSize: 18,
            minFontSize: 16,
            style: TextStyle(
              fontFamily: 'Questrial',
              color: AppColor.white,
              fontSize: screenSize.width * 0.03,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlay(double borderRadius) {
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isExpanded = isDesktop ? _isHovering : widget.isExpandedMobile;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 7.0, end: isExpanded ? 0.0 : 7.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        builder: (context, blurValue, child) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: AppColor.background.withValues(
              alpha: isExpanded ? 0.1 : 0.6,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer(double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        widget.certificate['image']!,
        height: 500,
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}
