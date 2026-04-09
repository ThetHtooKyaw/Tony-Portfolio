import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';

class AnimatedHoverSkillCard extends StatefulWidget {
  final Map<String, String> skill;
  const AnimatedHoverSkillCard({super.key, required this.skill});

  @override
  State<AnimatedHoverSkillCard> createState() => _AnimatedHoverSkillCardState();
}

class _AnimatedHoverSkillCardState extends State<AnimatedHoverSkillCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isTablet = ResponsiveWidget.isTablet(context);

    final textSize = isDesktop || isTablet
        ? (screenSize.width * 0.04).clamp(10.0, 18.0)
        : (screenSize.width * 0.03).clamp(10.0, 14.0);

    final iconSize = isDesktop || isTablet
        ? (screenSize.width * 0.04).clamp(14.0, 22.0)
        : (screenSize.width * 0.03).clamp(14.0, 18.0);

    Widget card = AnimatedContainer(
      transform: Matrix4.translationValues(0, _isHovering ? -10.0 : 0, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: AppColor.card,
        border: Border.all(color: AppColor.card, width: 1.0),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Default Text
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    widget.skill['icon'] ?? '',
                    height: iconSize,
                    width: iconSize,
                    color: AppColor.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.skill['text'] ?? '',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      color: AppColor.white,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Hover Animation
            Positioned(
              bottom: -10,
              child:
                  Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: AppColor.accent,
                          shape: BoxShape.circle,
                        ),
                      )
                      .animate(target: _isHovering ? 1 : 0)
                      .scale(
                        begin: Offset(0.0, 0.0),
                        end: Offset(7.0, 7.0),
                        duration: 500.ms,
                        curve: Curves.easeInOutCubic,
                      ),
            ),

            // Hover Text
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: ClipRect(
                  child:
                      Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                widget.skill['icon'] ?? '',
                                height: iconSize,
                                width: iconSize,
                                color: AppColor.background,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                widget.skill['text'] ?? '',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  color: AppColor.background,
                                  fontSize: textSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                          .animate(target: _isHovering ? 1 : 0)
                          .slide(
                            begin: const Offset(0.0, 1.0),
                            end: Offset.zero,
                            duration: 500.ms,
                            curve: Curves.easeOut,
                          ),
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
        child: card,
      );
    }

    return card;
  }
}
