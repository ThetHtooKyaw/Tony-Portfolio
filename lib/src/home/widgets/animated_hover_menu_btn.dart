import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';

class AnimatedHoverMenuBtn extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  const AnimatedHoverMenuBtn({super.key, required this.title, this.onPressed});

  @override
  State<AnimatedHoverMenuBtn> createState() => _AnimatedHoverMenuBtnState();
}

class _AnimatedHoverMenuBtnState extends State<AnimatedHoverMenuBtn> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final double fontSize = (MediaQuery.sizeOf(context).width * 0.025).clamp(
      18,
      20,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: widget.onPressed,
              child: Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'Questrial',
                  color: AppColor.background,
                  fontSize: fontSize,
                ),
              ),
            ),
            ClipRect(
              child: Container(color: AppColor.background, height: 2)
                  .animate(target: _isHovering ? 1 : 0)
                  .slide(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                    duration: 300.ms,
                    curve: Curves.easeOutCubic,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
