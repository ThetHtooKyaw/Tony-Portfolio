import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';

class StickySectionHeader extends SliverPersistentHeaderDelegate {
  final String title;
  final double screenWidth;
  const StickySectionHeader({required this.title, required this.screenWidth});

  double get _titleSize => (screenWidth * 0.06).clamp(30.0, 50.0);

  double get _headerHeight => _titleSize + 30.0;

  @override
  double get maxExtent => _headerHeight;

  @override
  double get minExtent => _headerHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool isScrolled) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppFormat.secondaryBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppFormat.secondaryPadding,
              horizontal: AppFormat.priamaryPadding,
            ),
            decoration: BoxDecoration(
              color: AppColor.background.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(
                AppFormat.secondaryBorderRadius,
              ),
            ),

            child: Text(
              title,
              style: TextStyle(
                // foreground: Paint()
                //   ..color = AppColor.accent
                //   ..blendMode = BlendMode.difference,
                color: AppColor.accent,
                fontFamily: 'Racing Sans One',
                fontSize: _titleSize,
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(StickySectionHeader oldDelegate) {
    return title != oldDelegate.title || screenWidth != oldDelegate.screenWidth;
  }
}
