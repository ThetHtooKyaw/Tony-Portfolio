import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:marquee/marquee.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';

class HomeLandingSection extends StatefulWidget {
  final ScrollController scrollController;
  const HomeLandingSection({super.key, required this.scrollController});

  @override
  State<HomeLandingSection> createState() => _HomeLandingSectionState();
}

class _HomeLandingSectionState extends State<HomeLandingSection> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    final double titleSize = (screenSize.width * 0.18).clamp(100.0, 280.0);

    return Container(
      height: screenSize.height,
      width: double.infinity,
      color: AppColor.white,
      child: Stack(
        children: [
          // Background Profile
          ClipRect(
            child: AnimatedBuilder(
              animation: widget.scrollController,
              builder: (context, child) {
                double scrollOffset = 0.0;
                if (widget.scrollController.hasClients) {
                  scrollOffset = widget.scrollController.offset;
                }

                final parallaxOffset = (scrollOffset * 0.5).clamp(
                  0.0,
                  screenSize.height,
                );

                return Transform.translate(
                  offset: Offset(0, parallaxOffset),
                  child: child,
                );
              },
              child:
                  Image.asset(
                        'assets/images/tony.png',
                        fit: BoxFit.cover,
                        height: screenSize.height,
                        width: double.infinity,
                      )
                      .animate()
                      .scale(
                        begin: Offset(3, 3),
                        end: Offset(1.3, 1.3),
                        duration: 1.seconds,
                        curve: Curves.easeIn,
                      )
                      .fadeIn(duration: 1.seconds),
            ),
          ),

          // My Name
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: titleSize,
              child:
                  Marquee(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        startPadding: 40,
                        text: "Thet Htoo Kyaw - Tony Johnson - " * 5,
                        blankSpace: 0,
                        velocity: 50,
                        accelerationDuration: Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        scrollAxis: Axis.horizontal,
                        style: TextStyle(
                          height: 1,
                          fontFamily: 'Racing Sans One',
                          foreground: Paint()
                            ..color = AppColor.white
                            ..blendMode = BlendMode.difference,
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      .animate()
                      .slideX(
                        begin: 3.0,
                        end: 0,
                        duration: 2.seconds,
                        curve: Curves.easeInOutCubic,
                      )
                      .scale(
                        begin: Offset(0.2, 0.2),
                        end: Offset(1.0, 1.0),
                        duration: 2.seconds,
                        curve: Curves.easeInOutCubic,
                      ),
            ),
          ),
          const SizedBox(height: 20),

          // My Roles
          Positioned(
            bottom: 40,
            left: (screenSize.width * 0.025).clamp(
              10.0,
              AppFormat.priamaryPadding,
            ),
            child:
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubTitleText(
                      text: "//",
                      screenWidth: screenSize.width,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ["Mobile Developer", "Web Developer"]
                          .map(
                            (role) => _buildSubTitleText(
                              text: role,
                              screenWidth: screenSize.width,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ).animate().slide(
                  begin: const Offset(0.0, 1.4),
                  end: Offset.zero,
                  duration: 600.ms,
                  delay: 1600.ms,
                  curve: Curves.easeIn,
                ),
          ),

          // Black Screen Fade Out
          IgnorePointer(
            child: Container(
              height: screenSize.height,
              width: double.infinity,
              color: AppColor.background,
            ).animate().fadeOut(duration: 2.seconds, delay: 0.seconds),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTitleText({
    required String text,
    required double screenWidth,
  }) {
    return AutoSizeText(
      text,
      maxFontSize: 60,
      minFontSize: 30,
      style: TextStyle(
        fontFamily: 'Oswald',
        foreground: Paint()
          ..color = AppColor.white
          ..blendMode = BlendMode.difference,
        fontSize: screenWidth * 0.06,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
