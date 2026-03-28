import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'package:tony_portfolio/core/data/project_info.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/home/widgets/responsive_widget.dart';

class HomeProjectSection extends StatefulWidget {
  final ScrollController scrollController;
  const HomeProjectSection({super.key, required this.scrollController});

  @override
  State<HomeProjectSection> createState() => _HomeProjectSectionState();
}

class _HomeProjectSectionState extends State<HomeProjectSection> {
  final GlobalKey _sectionKey = GlobalKey();
  Offset? _mouseOffset;
  bool _isHovering = false;

  bool _isProjectScrollable(Size screenSize) {
    final section = _sectionKey.currentContext?.findRenderObject();
    if (section is! RenderBox) return false;

    final top = section.localToGlobal(Offset.zero).dy;
    final bottom = top + section.size.height;
    final viewportHeight = widget.scrollController.hasClients
        ? widget.scrollController.position.viewportDimension
        : screenSize.height;

    final visibleTop = math.max(top, 0.0);
    final visibleBottom = math.min(bottom, viewportHeight);
    final visibleHeight = math.max(0.0, visibleBottom - visibleTop);
    final visibleRatio = visibleHeight / section.size.height;

    return visibleRatio >= 0.98;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);

    const double cardHeight = 650;
    const double padding = 400;
    final double step = cardHeight + padding;

    return Stack(
      children: [
        AnimatedBuilder(
          animation: widget.scrollController,
          builder: (context, _) {
            final active = _isProjectScrollable(screenSize);

            return Container(
              key: _sectionKey,
              padding: EdgeInsets.symmetric(
                vertical: AppFormat.priamaryPadding,
                horizontal: isDesktop ? 40 : AppFormat.priamaryPadding,
              ),
              height: screenSize.height,
              width: double.infinity,
              color: AppColor.background,
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: cardHeight,
                child: isDesktop
                    ? MouseRegion(
                        onHover: (event) => setState(() {
                          final box = _sectionKey.currentContext
                              ?.findRenderObject();
                          if (box is RenderBox) {
                            final local = box.globalToLocal(event.position);
                            _mouseOffset = local;
                            _isHovering = true;
                          }
                        }),
                        onExit: (_) => setState(() {
                          _mouseOffset = null;
                          _isHovering = false;
                        }),
                        cursor: _isHovering
                            ? SystemMouseCursors.none
                            : SystemMouseCursors.basic,
                        child: IgnorePointer(
                          ignoring: !active,
                          child: StackedCardCarousel(
                            type: StackedCardCarouselType.fadeOutStack,
                            initialOffset: 0,
                            spaceBetweenItems: step,
                            applyTextScaleFactor: false,
                            items: projectInfos.map((project) {
                              return _buildDesktopCard(
                                screenWidth: screenSize.width,
                                projectData: project,
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    : IgnorePointer(
                        ignoring: !active,
                        child: StackedCardCarousel(
                          type: StackedCardCarouselType.fadeOutStack,
                          initialOffset: 0,
                          spaceBetweenItems: step,
                          applyTextScaleFactor: false,
                          items: projectInfos.map((project) {
                            return _buildMobileCard(
                              screenWidth: screenSize.width,
                              projectData: project,
                            );
                          }).toList(),
                        ),
                      ),
              ),
            );
          },
        ),

        if (_mouseOffset != null)
          Positioned(
            top: _mouseOffset!.dy,
            left: _mouseOffset!.dx,
            child: _buildCustomCursor(screenSize.width),
          ),
      ],
    );
  }

  Widget _buildCustomCursor(double screenWidth) {
    return Container(
          height: (screenWidth * 0.03).clamp(60.0, 120.0),
          width: (screenWidth * 0.03).clamp(60.0, 120.0),
          decoration: BoxDecoration(
            color: AppColor.accent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'View',
              style: TextStyle(fontFamily: 'Questrial', color: Colors.white),
            ),
          ),
        )
        .animate(target: _isHovering ? 1 : 0)
        .scale(
          begin: Offset(0.1, 0.1),
          end: Offset(1.0, 1.0),
          duration: 300.ms,
          curve: Curves.easeInOut,
        );
  }

  Widget _buildDesktopCard({
    required double screenWidth,
    required Map<String, dynamic> projectData,
  }) {
    final icons = (projectData['icons'] as List).cast<String>();
    final features = (projectData['features'] as List).cast<String>();

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildImageContainer(imagePaths: projectData['image']),
        ),
        const SizedBox(width: 20),

        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all((screenWidth * 0.02).clamp(20.0, 40.0)),
            height: 650,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.disable),
              borderRadius: BorderRadius.circular(
                AppFormat.primaryBorderRadius,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Project Date
                Text(
                  projectData['date'],
                  style: TextStyle(
                    fontFamily: 'Questrial',
                    color: AppColor.white,
                    fontSize: 20,
                    height: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Project Name
                AutoSizeText(
                  projectData['name'],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  maxFontSize: 50.0,
                  minFontSize: 30.0,
                  style: TextStyle(
                    fontFamily: 'Racing Sans One',
                    color: AppColor.white,
                    fontSize: screenWidth * 0.03,
                    height: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Tech Stack Icon
                _buildIconList(
                  icons: icons,
                  radiusSize: (screenWidth * 0.03).clamp(20.0, 26.0),
                  iconSize: (screenWidth * 0.03).clamp(24.0, 26.0),
                ),
                const Spacer(),

                // Project Description
                ..._buildFeatureList(
                  screenWidth: screenWidth,
                  features: features,
                  maxFontSize: 22.0,
                  minFontSize: 16.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileCard({
    required double screenWidth,
    required Map<String, dynamic> projectData,
  }) {
    final icons = (projectData['icons'] as List).cast<String>();
    final features = (projectData['features'] as List).cast<String>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildImageContainer(imagePaths: projectData['image'], isMobile: true),
        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(AppFormat.priamaryPadding),
          height: 230,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.disable),
            borderRadius: BorderRadius.circular(AppFormat.primaryBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Project Name
              AutoSizeText(
                '${projectData['name']} ${projectData['date']}',
                maxFontSize: 20.0,
                minFontSize: 18.0,
                style: TextStyle(
                  fontFamily: 'Racing Sans One',
                  color: AppColor.white,
                  fontSize: screenWidth * 0.03,
                  height: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Tech Stack Icon
              _buildIconList(icons: icons, radiusSize: 20, iconSize: 24),
              const SizedBox(height: 20),

              // Project Description
              ..._buildFeatureList(
                screenWidth: screenWidth,
                features: features,
                maxFontSize: 18.0,
                minFontSize: 16.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer({
    required List<String> imagePaths,
    bool isMobile = false,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = constraints.maxWidth;
        final mobileRatio = containerWidth <= 400.0
            ? imagePaths.first
            : imagePaths.last;
        final desktopRatio = containerWidth <= 600.0
            ? imagePaths.first
            : imagePaths.last;
        final imagePath = isMobile ? mobileRatio : desktopRatio;

        return Container(
          height: isMobile ? 400 : 650,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppFormat.primaryBorderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppFormat.primaryBorderRadius),
            child: Image.asset(imagePath, fit: BoxFit.fill),
          ),
        );
      },
    );
  }

  Widget _buildIconList({
    required List<String> icons,
    required double radiusSize,
    required double iconSize,
  }) {
    return Row(
      children: [
        ...icons.map(
          (icon) => Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: CircleAvatar(
              radius: radiusSize,
              backgroundColor: AppColor.white.withValues(alpha: 0.1),
              child: Image.asset(
                icon,
                height: iconSize,
                width: iconSize,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFeatureList({
    required double screenWidth,
    required List<String> features,
    required double maxFontSize,
    required double minFontSize,
  }) {
    return features.asMap().entries.map((entry) {
      final index = entry.key;
      final feature = entry.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            feature,
            maxFontSize: maxFontSize,
            minFontSize: minFontSize,
            style: TextStyle(
              fontFamily: 'Open Sans',
              color: AppColor.placeholder,
              fontSize: screenWidth * 0.02,
            ),
          ),
          if (index != features.length - 1)
            Divider(color: AppColor.disable, thickness: 1, height: 8),
        ],
      );
    }).toList();
  }
}
