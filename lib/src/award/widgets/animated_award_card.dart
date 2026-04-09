import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/data/hackathon_info.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedAwardCard extends StatefulWidget {
  const AnimatedAwardCard({super.key});

  @override
  State<AnimatedAwardCard> createState() => _AnimatedAwardCardState();
}

class _AnimatedAwardCardState extends State<AnimatedAwardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeInAnimation;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleUrlLaunch() async {
    final Uri url = Uri.parse(hackathonInfos[0]['url']);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isTablet = ResponsiveWidget.isTablet(context);

    return VisibilityDetector(
      key: Key('award-${hackathonInfos[0]}'),
      onVisibilityChanged: (awardCard) {
        if (awardCard.visibleFraction > 0.1) {
          if (_controller.status == AnimationStatus.dismissed ||
              _controller.status == AnimationStatus.reverse) {
            _controller.forward();
          } else if (awardCard.visibleFraction == 0) {
            _controller.reset();
            isExpanded = false;
          }
        }
      },
      child: FadeTransition(
        opacity: _fadeInAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: isDesktop
                    ? screenSize.width * 0.8
                    : isTablet
                    ? screenSize.width * 0.75
                    : double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.shadow.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: isDesktop
                    ? _buildDesktopCard(screenWidth: screenSize.width)
                    : _buildMobileCard(screenWidth: screenSize.width),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopCard({required double screenWidth}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Project Image & Award
        _buildImageContainer(
          imageHeight: (screenWidth * 0.2).clamp(200, 300),
          imageWidth: (screenWidth * 0.25).clamp(200, 500),
        ),
        SizedBox(width: (screenWidth * 0.25).clamp(20, 40)),

        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${hackathonInfos[0]['projectName']} - ${hackathonInfos[0]['eventName']}',
                  style: TextStyle(
                    color: AppColor.white,
                    fontFamily: 'Oswald',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Tech Stack Icons
                Row(
                  children: hackathonInfos[0]['icons'].map<Widget>((icon) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(icon, width: 24, height: 24),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Description
                Text(
                  hackathonInfos[0]['description'],
                  maxLines: isExpanded ? 20 : 7,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.light,
                    fontFamily: 'Open Sans',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileCard({required double screenWidth}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project Image & Award
        Center(
          child: _buildImageContainer(
            imageHeight: 300,
            imageWidth: double.infinity,
          ),
        ),
        const SizedBox(height: 20),

        Center(
          child: AutoSizeText(
            '${hackathonInfos[0]['projectName']} - ${hackathonInfos[0]['eventName']}',
            maxFontSize: 30,
            minFontSize: 18,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.white,
              fontFamily: 'Oswald',
              fontSize: screenWidth * 0.1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Tech Stack Icons
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: hackathonInfos[0]['icons'].map<Widget>((icon) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(icon, width: 24, height: 24),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),

        GestureDetector(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: AutoSizeText(
            hackathonInfos[0]['description'],
            maxLines: isExpanded ? 20 : 6,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            maxFontSize: 16,
            minFontSize: 10,
            style: TextStyle(
              color: AppColor.light,
              fontFamily: 'Open Sans',
              fontSize: screenWidth * 0.03,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer({
    required double imageHeight,
    required double imageWidth,
  }) {
    return GestureDetector(
      onTap: () => _handleUrlLaunch(),
      child: Container(
        height: imageHeight,
        width: imageWidth,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Project Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                hackathonInfos[0]['image'][0],
                height: imageHeight,
                width: imageWidth,
                fit: BoxFit.fill,
              ),
            ),

            // Award
            Positioned(
              bottom: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/trophy.png',
                          width: 20,
                          height: 20,
                          color: const Color(0xFFFFD700),
                        ),
                        const SizedBox(width: 10),

                        Text(
                          hackathonInfos[0]['award'],
                          style: TextStyle(
                            color: AppColor.white,
                            fontFamily: 'Questrial',
                            fontSize: 20,
                            height: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
