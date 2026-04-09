import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';

class AnimatedHoverHightlightCard extends StatefulWidget {
  final bool isExpLabel;
  final Animation<double> animation;

  const AnimatedHoverHightlightCard({
    super.key,
    this.isExpLabel = false,
    required this.animation,
  });

  @override
  State<AnimatedHoverHightlightCard> createState() =>
      _AnimatedHoverHightlightCardState();
}

class _AnimatedHoverHightlightCardState
    extends State<AnimatedHoverHightlightCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final fieldQuantity = widget.isExpLabel ? 3 : 20;

    Widget largeCard = _buildCardBox(
      isLargeCard: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: AppColor.white.withValues(alpha: 0.1),
                child: Image.asset(
                  widget.isExpLabel
                      ? 'assets/icons/code.png'
                      : 'assets/icons/project.png',
                  color: _isHovering ? AppColor.accent : AppColor.white,
                  width: 24,
                  height: 24,
                ),
              ),

              // Field Quantity
              _buildFieldQuantity(fieldQuantity: fieldQuantity),
            ],
          ),
          const SizedBox(height: 10),

          // Label
          AutoSizeText(
            widget.isExpLabel ? 'YEARS OF EXPERIENCES' : 'PROJECTS COMPLETED',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            maxFontSize: 18.0,
            minFontSize: 14.0,
            style: TextStyle(
              fontFamily: 'Open Sans',
              color: AppColor.white,
              fontSize: screenSize.width * 0.03,
            ),
          ),

          // Description
          AutoSizeText(
            widget.isExpLabel
                ? "Specializing in Flutter & Firebase"
                : "From Concept to Production-Ready Apps",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            maxFontSize: 14.0,
            minFontSize: 10.0,
            style: TextStyle(
              fontFamily: 'Open Sans',
              color: AppColor.placeholder,
              fontSize: screenSize.width * 0.03,
            ),
          ),
        ],
      ),
    );

    Widget smallCard = _buildCardBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Background Label
              Opacity(
                opacity: 0.2,
                child: AutoSizeText(
                  widget.isExpLabel ? 'EXPERIENCES' : 'PROJECTS',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  maxFontSize: 40.0,
                  minFontSize: 18.0,
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: AppColor.white,
                    fontSize: screenSize.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Field Quantity
              _buildFieldQuantity(
                fieldQuantity: fieldQuantity,
                isSmallCard: true,
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Description
          AutoSizeText(
            widget.isExpLabel ? "Flutter & Firebase" : "Production-Ready Apps",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            maxFontSize: 14.0,
            minFontSize: 10.0,
            style: TextStyle(
              fontFamily: 'Open Sans',
              color: AppColor.placeholder,
              fontSize: screenSize.width * 0.03,
            ),
          ),
        ],
      ),
    );

    if (ResponsiveWidget.isDesktop(context)) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: largeCard,
      );
    }

    if (ResponsiveWidget.isTablet(context)) {
      return largeCard;
    }

    return smallCard;
  }

  Widget _buildFieldQuantity({
    required int fieldQuantity,
    bool isSmallCard = false,
  }) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        int currentNumber = (fieldQuantity * widget.animation.value).ceil();

        return Text(
          '$currentNumber+',
          style: TextStyle(
            fontFamily: 'Oswald',
            color: AppColor.accent,
            fontSize: 46,
            height: 1.0,
            fontWeight: FontWeight.bold,
            shadows: isSmallCard
                ? [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(0, 2),
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
        );
      },
    );
  }

  Widget _buildCardBox({bool isLargeCard = false, required Widget child}) {
    return Container(
      padding: isLargeCard
          ? EdgeInsets.all(AppFormat.priamaryPadding)
          : const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: AppFormat.priamaryPadding,
            ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.card,
        border: Border.all(color: AppColor.card, width: 1),
        borderRadius: BorderRadius.circular(AppFormat.primaryBorderRadius),
        boxShadow: _isHovering
            ? [
                BoxShadow(
                  color: AppColor.shadow,
                  blurRadius: 20,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
