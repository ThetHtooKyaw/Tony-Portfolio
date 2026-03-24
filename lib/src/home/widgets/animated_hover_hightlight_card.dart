import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';

class AnimatedHoverHightlightCard extends StatefulWidget {
  final int targetNumber;
  final String title;
  final String desc;
  final String icon;
  final Animation<double> animation;

  const AnimatedHoverHightlightCard({
    super.key,
    required this.targetNumber,
    required this.title,
    required this.desc,
    required this.icon,
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

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Container(
        padding: const EdgeInsets.all(AppFormat.priamaryPadding),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.white.withValues(alpha: 0.1),
                  child: Image.asset(
                    widget.icon,
                    color: _isHovering ? AppColor.accent : AppColor.white,
                    width: 24,
                    height: 24,
                  ),
                ),
                AnimatedBuilder(
                  animation: widget.animation,
                  builder: (context, child) {
                    int currentNumber =
                        (widget.targetNumber * widget.animation.value).ceil();

                    return Text(
                      '$currentNumber+',
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        color: AppColor.accent,
                        fontSize: 46,
                        height: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Open Sans',
                color: AppColor.white,
                fontSize: (screenSize.width * 0.03).clamp(14.0, 18.0),
              ),
            ),
            Text(
              widget.desc,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Open Sans',
                color: AppColor.placeholder,
                fontSize: (screenSize.width * 0.03).clamp(10.0, 14.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
