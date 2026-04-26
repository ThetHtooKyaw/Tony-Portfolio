import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';

class AnimatedTextMenuBtn extends StatefulWidget {
  final String title;
  final Duration delay;
  final VoidCallback onPressed;

  const AnimatedTextMenuBtn({
    super.key,
    required this.title,
    required this.delay,
    required this.onPressed,
  });

  @override
  State<AnimatedTextMenuBtn> createState() => _AnimatedTextMenuBtnState();
}

class _AnimatedTextMenuBtnState extends State<AnimatedTextMenuBtn> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child:
          TextButton(
            onPressed: widget.onPressed,
            child: Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'Oswald',
                color: AppColor.white,
                fontSize: 18,
              ),
            ),
          ).animate().slide(
            begin: const Offset(0.0, 1.4),
            end: Offset.zero,
            duration: 300.ms,
            curve: Curves.easeOutCubic,
            delay: widget.delay,
          ),
    );
  }
}
