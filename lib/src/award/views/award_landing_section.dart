import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/award/widgets/animated_award_card.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';

class AwardLandingSection extends StatefulWidget {
  final ScrollController scrollController;
  const AwardLandingSection({super.key, required this.scrollController});

  @override
  State<AwardLandingSection> createState() => _AwardLandingSectionState();
}

class _AwardLandingSectionState extends State<AwardLandingSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    double delta = details.primaryDelta ?? 0.0;
    double factor = 0.002;
    _controller.value = (_controller.value - delta * factor).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isLargeScreen = ResponsiveWidget.isLargeScreen(context);

    return Container(
      height: isDesktop ? screenSize.height * 2.0 : screenSize.height * 2.4,
      width: double.infinity,
      color: AppColor.background,
      child: AnimatedBuilder(
        animation: widget.scrollController,
        builder: (context, child) {
          double scrollOffset = 0.0;

          if (widget.scrollController.hasClients) {
            scrollOffset = widget.scrollController.offset;
          }

          // Responsive Logic
          final double minWidth = 600;
          final double maxWidth = 1600;
          final double minOffset = 100;
          final double maxOffset = 50;

          final double t =
              (1 - ((screenSize.width - minWidth) / (maxWidth - minWidth)))
                  .clamp(0.0, 1.0);
          final double topOffset = maxOffset + (minOffset - maxOffset) * t;

          // Parallax Effect Animation Logic
          final double parallaxOffsetY = scrollOffset.clamp(
            0.0,
            screenSize.height * 3.0,
          );

          final double startScroll = screenSize.height * 0.4;
          final double endScroll = screenSize.height * 1.0;
          final double reverseEndScroll = screenSize.height * 1.5;

          double progress = 0.0;
          if (scrollOffset >= startScroll && scrollOffset <= endScroll) {
            progress =
                ((scrollOffset - startScroll) / (endScroll - startScroll))
                    .clamp(0.0, 1.0);
          } else if (scrollOffset > endScroll &&
              scrollOffset <= reverseEndScroll) {
            progress =
                1.0 -
                ((scrollOffset - endScroll) / (reverseEndScroll - endScroll))
                    .clamp(0.0, 1.0);
          }

          // Size Animation Logic
          final double earthWidthStart = (screenSize.width * 0.9).clamp(
            600.0,
            1600.0,
          );
          final double earthWidthEnd = (screenSize.width * 0.9).clamp(
            300.0,
            1000.0,
          );

          final double earthWidth =
              earthWidthStart - (earthWidthStart - earthWidthEnd) * progress;

          return ClipRRect(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Earth Animation
                Positioned(
                  top: topOffset,
                  child: _buildLottieAnimation(parallaxOffsetY, earthWidth),
                ),

                // Landing Title
                Positioned(
                  top: screenSize.height * 0.74,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children:
                        [
                          _buildLandingText(
                            screenSize: screenSize,
                            text: 'HACKATHON',
                            maxFontSize: 300,
                            minFontSize: 40,
                          ),
                          _buildLandingText(
                            screenSize: screenSize,
                            text: 'ENTRIES',
                            maxFontSize: 80,
                            minFontSize: 20,
                          ),
                        ].animate().slide(
                          begin: const Offset(0.0, 1.0),
                          end: Offset.zero,
                          duration: 800.ms,
                          curve: Curves.easeIn,
                        ),
                  ),
                ),

                // Foreground Title
                Positioned(
                  top: screenSize.height * 1.2,
                  child: AutoSizeText(
                    '" JUST DO IT "',
                    maxFontSize: 40,
                    minFontSize: 20,
                    style: TextStyle(
                      foreground: Paint()
                        ..color = AppColor.accent
                        ..blendMode = BlendMode.difference,
                      // color: AppColor.accent,
                      fontFamily: 'Racing Sans One',
                      height: 1,
                      fontSize: screenSize.width * 0.10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Hackathon Content
                Positioned(
                  top: screenSize.height * 1.4,
                  left: isLargeScreen ? null : AppFormat.priamaryPadding,
                  right: isLargeScreen ? null : AppFormat.priamaryPadding,
                  child: AnimatedAwardCard(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLottieAnimation(double parallaxOffsetY, double earthWidth) {
    return GestureDetector(
      onTapDown: (_) => _controller.stop(),
      onTapUp: (_) => _controller.repeat(),
      onTapCancel: () => _controller.repeat(),
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: (_) => _controller.repeat(),
      child: Transform.translate(
        offset: Offset(0.0, parallaxOffsetY),
        child:
            Container(
                  width: earthWidth,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadow,
                        blurRadius: 100,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Lottie.asset(
                    'assets/animations/earth.json',
                    controller: _controller,
                    repeat: true,
                    onLoaded: (composition) {
                      _controller
                        ..duration = composition.duration
                        ..repeat();
                    },
                    delegates: LottieDelegates(
                      values: [
                        ValueDelegate.color(const [
                          'Land/earth_color.ai 2',
                          '**',
                        ], value: AppColor.accent),
                      ],
                    ),
                    fit: BoxFit.contain,
                  ),
                )
                .animate()
                .scale(
                  begin: Offset(0.3, 0.3),
                  end: Offset(1.0, 1.0),
                  duration: 1.seconds,
                  curve: Curves.easeIn,
                )
                .fadeIn(duration: 600.ms),
      ),
    );
  }

  Widget _buildLandingText({
    required Size screenSize,
    required String text,
    required double maxFontSize,
    required double minFontSize,
  }) {
    return AutoSizeText(
      text,
      maxFontSize: maxFontSize,
      minFontSize: minFontSize,
      textAlign: TextAlign.center,
      style: TextStyle(
        // foreground: Paint()
        //   ..color = AppColor.accent
        //   ..blendMode = BlendMode.difference,
        color: AppColor.white,
        fontFamily: 'Racing Sans One',
        height: 1,
        fontSize: screenSize.width * 0.16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
