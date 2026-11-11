import 'package:flutter/material.dart';

import '../theme/app_color.dart';
import '../theme/app_format.dart';
import '../utils/responsive_widget.dart';
import 'animated_hover_menu_btn.dart';

class BottomBar extends StatelessWidget {
  final ScrollController scrollController;
  final bool? isDetailView;
  const BottomBar({
    super.key,
    required this.scrollController,
    this.isDetailView = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isLargeScreen = ResponsiveWidget.isLargeScreen(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (screenSize.width * 0.03).clamp(
          AppFormat.primaryPadding,
          40.0,
        ),
      ),
      height: isLargeScreen ? 100 : 80,
      width: screenSize.width,
      color: AppColor.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Copyright
          AnimatedHoverMenuBtn(
            title: '© 2026 Tony Johnson',
            fontSize: (screenSize.width * 0.025).clamp(16, 20),
          ),

          // Project Label
          if (isLargeScreen || isDetailView!)
            AnimatedHoverMenuBtn(
              title: 'Tony\'s Portfolio',
              fontSize: (screenSize.width * 0.025).clamp(
                isDetailView! ? 16 : 22,
                isDetailView! ? 20 : 34,
              ),
            ),

          // Back to Top Button
          if (!isDetailView!)
            GestureDetector(
              onTap: () {
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Row(
                children: [
                  AnimatedHoverMenuBtn(
                    title: 'Back to Top',
                    fontSize: (screenSize.width * 0.025).clamp(16, 20),
                  ),
                  const SizedBox(width: 10),

                  Icon(
                    Icons.arrow_upward,
                    color: AppColor.white,
                    size: (screenSize.width * 0.025).clamp(16, 20),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
