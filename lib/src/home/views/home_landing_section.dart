import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:marquee/marquee.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/home/widgets/blend_mask.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final bool isDesktop = screenSize.width > 600;

    final double titleSize = (screenSize.width * 0.18).clamp(130, 280);
    final double subTitleSize = (screenSize.width * 0.06).clamp(34, 60);

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

                final double parallaxOffset = (scrollOffset * 0.5).clamp(
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
            left: isDesktop ? AppFormat.priamaryPadding : 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubTitleText(text: "//", fontSize: subTitleSize),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: ["Mobile Developer", "Web Developer"]
                      .map(
                        (role) => _buildSubTitleText(
                          text: role,
                          fontSize: subTitleSize,
                        ),
                      )
                      .toList(),
                ),
              ],
            ).animate().fadeIn(duration: 2.seconds, delay: 1800.ms),
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

  Widget _buildSubTitleText({required String text, required double fontSize}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Oswald',
        foreground: Paint()
          ..color = AppColor.white
          ..blendMode = BlendMode.difference,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

Widget buildFloatingBtn({required Size screenSize}) {
  final double iconSize = (screenSize.width * 0.05).clamp(20, 30);
  final double padding = (screenSize.width * 0.01).clamp(0, 10);

  return RepaintBoundary(
    child: BlendMask(
      blendMode: BlendMode.difference,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.white),
          borderRadius: BorderRadius.circular(AppFormat.circleBorderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              [
                {
                  'icon': 'assets/icons/github.png',
                  'tooltip': 'GitHub',
                  'url': 'https://github.com/ThetHtooKyaw',
                },
                {
                  'icon': 'assets/icons/linkedin.png',
                  'tooltip': 'LinkedIn',
                  'url': 'https://www.linkedin.com/in/tonyjohnsons/',
                },
                {
                  'icon': 'assets/icons/gmail.png',
                  'tooltip': 'Gmail',
                  'url': 'mailto:2003tonyc123@gmail.com',
                },
              ].map((social) {
                return IconButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(social['url']!);

                    if (!await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    )) {
                      debugPrint('Could not launch ${social['url']}');
                    }
                  },
                  icon: Image.asset(
                    social['icon']!,
                    width: iconSize,
                    height: iconSize,
                    color: AppColor.white,
                  ),
                  tooltip: social['tooltip']!,
                );
              }).toList(),
        ),
      ),
    ),
  ).animate().fadeIn(duration: 2.seconds, delay: 1900.ms);
}
