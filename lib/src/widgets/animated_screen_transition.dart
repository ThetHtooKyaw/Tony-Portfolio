import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';

class AnimatedScreenTransition extends CustomTransitionPage {
  AnimatedScreenTransition({required Widget newScreen, required LocalKey key})
    : super(
        key: key,
        child: newScreen,
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );

          return Stack(
            children: [
              AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  return Opacity(
                    opacity: animation.value >= 0.5 ? 1.0 : 0.0,
                    child: child,
                  );
                },
              ),

              AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  double t = curvedAnimation.value;
                  double yOffset;

                  if (t < 0.45) {
                    yOffset = 1.0 - (t / 0.45);
                  } else if (t >= 0.45 && t <= 0.55) {
                    yOffset = 0.0;
                  } else {
                    yOffset = (t - 0.55) / 0.45;
                  }

                  return FractionalTranslation(
                    translation: Offset(0.0, yOffset),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: AppColor.accent,
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
}
