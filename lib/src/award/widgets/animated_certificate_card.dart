import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:tony_portfolio/src/award/model/certificate_model.dart';

class AnimatedCertificateCard extends StatefulWidget {
  final MinorCertificateModel certificate;
  final bool isExpandedMobile;
  final VoidCallback onTapMobile;

  const AnimatedCertificateCard({
    super.key,
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
    if (widget.certificate.detail == false) return;

    context.push('/certificates', extra: widget.certificate.certificates);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isExpanded = isDesktop ? _isHovering : widget.isExpandedMobile;
    final certificate = widget.certificate;

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
            _buildImageContainer(),

            // "See More" Button
            if (certificate.detail == true)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: _buildButton(screenSize, isLargeCard: true),
                ),
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
                        certificate.title,
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

    Widget smallCard = GestureDetector(
      onTap: isExpanded ? _handleSeeMore : widget.onTapMobile,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: isExpanded ? 400 : 150,
        width: screenSize.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            // Certificate Image
            _buildImageContainer(),

            // "See More" Button
            if (certificate.detail == true)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: _buildButton(screenSize, isLargeCard: false),
                ),
              ),

            // Foreground Overlay
            _buildOverlay(20),

            // Certificate Title
            isExpanded
                ? const SizedBox.shrink()
                : Center(
                    child: AutoSizeText(
                      certificate.title,
                      maxFontSize: 20,
                      minFontSize: 16,
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

    return smallCard;
  }

  Widget _buildButton(Size screenSize, {required bool isLargeCard}) {
    Widget buttonContent(double bottomRadius) {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: const Radius.circular(14),
          bottom: Radius.circular(isLargeCard ? bottomRadius : 0),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              color: AppColor.shadow,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(14),
                bottom: Radius.circular(isLargeCard ? bottomRadius : 0),
              ),
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

    if (isLargeCard) {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 12.0, end: _isHovering ? 0.0 : 12.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        builder: (context, bottomRadius, _) => buttonContent(bottomRadius),
      );
    }

    return buttonContent(12.0);
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

  Widget _buildImageContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        widget.certificate.image,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
