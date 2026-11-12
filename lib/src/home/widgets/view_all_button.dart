import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/utils/responsive_widget.dart';

class ViewAllButton extends StatefulWidget {
  final VoidCallback onPressed;
  const ViewAllButton({super.key, required this.onPressed});

  @override
  State<ViewAllButton> createState() => _ViewAllButtonState();
}

class _ViewAllButtonState extends State<ViewAllButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);

    final card = TextButton(
      onPressed: widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            maxFontSize: 16,
            minFontSize: 12,
            'View All Projects',
            style: TextStyle(
              color: _isHovering ? AppColor.accent : AppColor.white,
              fontSize: screenSize.width * 0.03,
              fontWeight: _isHovering ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 10),

          Icon(
            Icons.arrow_forward,
            color: _isHovering ? AppColor.accent : AppColor.white,
            size: 24,
          ),
        ],
      ),
    );

    if (isDesktop) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: card,
      );
    }

    return card;
  }
}
