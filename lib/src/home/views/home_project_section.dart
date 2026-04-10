import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'package:tony_portfolio/core/data/project_info.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return top <= 20.0 && bottom >= viewportHeight - 20.0;
  }

  void _handleUrlLaunch(String? projectUrl) async {
    if (projectUrl == null) return;

    final Uri url = Uri.parse(projectUrl);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);

    final double cardHeight = screenSize.height * 0.85;
    const double padding = 500;
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
                vertical: isDesktop ? 40 : AppFormat.priamaryPadding,
                horizontal: isDesktop ? 40 : AppFormat.priamaryPadding,
              ),
              width: double.infinity,
              height: screenSize
                  .height, // Force section to span exactly 1 whole screen
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
                                cardHeight: cardHeight,
                                projectData: project,
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    // TODO: Sync Mouse Cursor
                    : IgnorePointer(
                        ignoring: !active,
                        child: StackedCardCarousel(
                          type: StackedCardCarouselType.fadeOutStack,
                          initialOffset: 0,
                          spaceBetweenItems: step,
                          applyTextScaleFactor: false,
                          items: projectInfos.map((project) {
                            return _buildMobileCard(
                              screenSize: screenSize,
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
          height: (screenWidth * 0.08).clamp(60.0, 140.0),
          width: (screenWidth * 0.08).clamp(60.0, 140.0),
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
    required double cardHeight,
    required Map<String, dynamic> projectData,
  }) {
    final icons = (projectData['icons'] as List).cast<String>();
    final features = (projectData['features'] as List).cast<String>();

    return GestureDetector(
      onTap: () => _handleUrlLaunch(projectData['url']),
      child: Row(
        children: [
          // Project Image
          Expanded(
            flex: 2,
            child: _buildImageContainer(
              cardHeight: cardHeight,
              imagePaths: projectData['image'],
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all((screenWidth * 0.02).clamp(20.0, 40.0)),
              height: cardHeight,
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

                    iconSize: (screenWidth * 0.03).clamp(16.0, 30.0),
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
      ),
    );
  }

  Widget _buildMobileCard({
    required Size screenSize,
    required Map<String, dynamic> projectData,
  }) {
    final icons = (projectData['icons'] as List).cast<String>();
    final features = (projectData['features'] as List).cast<String>();

    return GestureDetector(
      onTap: () => _handleUrlLaunch(projectData['url']),
      child: SizedBox(
        height: screenSize.height * 0.85,
        child: Column(
          children: [
            // Project Image
            Expanded(
              flex: 5,
              child: _buildImageContainer(
                cardHeight: double.infinity,
                imagePaths: projectData['image'],
                isMobile: true,
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(AppFormat.priamaryPadding),
                width: double.infinity,
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
                    // Project Name
                    AutoSizeText(
                      '${projectData['name']} ${projectData['date']}',
                      maxFontSize: 20.0,
                      minFontSize: 18.0,
                      style: TextStyle(
                        fontFamily: 'Racing Sans One',
                        color: AppColor.white,
                        fontSize: screenSize.width * 0.03,
                        height: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tech Stack Icon
                    _buildIconList(icons: icons, iconSize: 24),
                    const Spacer(),

                    // Project Description
                    ..._buildFeatureList(
                      screenWidth: screenSize.width,
                      features: features,
                      maxFontSize: 18.0,
                      minFontSize: 14.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer({
    double cardHeight = 400,
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
          height: cardHeight,
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
    required double iconSize,
  }) {
    return Row(
      children: [
        ...icons.map(
          (icon) => Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(icon, height: iconSize, width: iconSize),
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
