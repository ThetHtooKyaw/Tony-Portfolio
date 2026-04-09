import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/src/home/widgets/blend_mask.dart';

class AnimatedHoverMenuBtn extends StatefulWidget {
  final String title;
  final double fontSize;
  final VoidCallback? onPressed;
  const AnimatedHoverMenuBtn({
    super.key,
    required this.title,
    required this.fontSize,
    this.onPressed,
  });

  @override
  State<AnimatedHoverMenuBtn> createState() => _AnimatedHoverMenuBtnState();
}

class _AnimatedHoverMenuBtnState extends State<AnimatedHoverMenuBtn> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
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
                  foreground: Paint()
                    ..color = AppColor.white
                    ..blendMode = BlendMode.difference,
                  fontSize: widget.fontSize,
                ),
              ),
            ),
            ClipRect(
              child: RepaintBoundary(
                child: BlendMask(
                  blendMode: BlendMode.difference,
                  child: Container(color: AppColor.white, height: 2)
                      .animate(target: _isHovering ? 1 : 0)
                      .slide(
                        begin: const Offset(-1.5, 0),
                        end: Offset.zero,
                        duration: 300.ms,
                        curve: Curves.easeOutCubic,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
