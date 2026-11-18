import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/model/project_model.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';
import '../../../core/utils/responsive_widget.dart';
import '../../projects/widgets/image_slider.dart';

class HackathonSection extends StatefulWidget {
  const HackathonSection({super.key});

  @override
  State<HackathonSection> createState() => _HackathonSectionState();
}

class _HackathonSectionState extends State<HackathonSection> {
  late PageController _mobilePageController;
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bool isTablet = ResponsiveWidget.isTablet(context);
    final double fraction = isTablet ? 0.75 : 0.95;

    _mobilePageController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: fraction,
    );
  }

  @override
  void dispose() {
    _mobilePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final bool isSmallScreen =
        ResponsiveWidget.isSmallScreen(context) ||
        ResponsiveWidget.isTablet(context);

    final projects = allProjects
        .where((p) => p.categories.contains('Hackathon'))
        .toList();

    if (projects.isEmpty) return const SizedBox.shrink();

    if (_selectedIndex >= projects.length) {
      _selectedIndex = 0;
    }

    if (isSmallScreen) {
      return _buildMobileCarousel(
        context: context,
        projects: projects,
        screenWidth: screenSize.width,
      );
    }

    final selectedProject = projects[_selectedIndex];

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sectionWidth = constraints.maxWidth;

        final double containerWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenSize.width * 0.85;

        final double desktopProgress = ((containerWidth - 1000) / (1600 - 1000))
            .clamp(0.0, 1.0);

        final double desktopImageSize = 200 + (100 * desktopProgress);
        final double desktopTitleFontSize = 24 + (12 * desktopProgress);

        // Scales type & description font sizes slightly for smooth scaling
        final double desktopTypeFontSize = 16 + (4 * desktopProgress);
        final double desktopDescFontSize = 13 + (1 * desktopProgress);

        return SizedBox(
          width: sectionWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Spotlight Card
              Expanded(
                flex: 7,
                child: GestureDetector(
                  onTap: () {
                    context.push('/project_detail', extra: selectedProject);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: EdgeInsets.all(AppFormat.primaryPadding),
                        decoration: BoxDecoration(
                          color: AppColor.shadow.withValues(alpha: 0.24),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: AppColor.disable.withValues(alpha: 0.25),
                            width: 1,
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Row(
                            key: ValueKey<int>(_selectedIndex),
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Project Image (Responsive desktop scaling)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppFormat.primaryBorderRadius,
                                ),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: desktopImageSize,
                                    maxWidth: desktopImageSize,
                                  ),
                                  child: ImageSlider(
                                    images: selectedProject.overviewImage!,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 32),

                              // Project Info
                              Expanded(
                                child: _buildProjectInfo(
                                  project: selectedProject,
                                  isDesktop: true,
                                  isMobile: false,
                                  titleFontSize: desktopTitleFontSize,
                                  typeFontSize: desktopTypeFontSize,
                                  descFontSize: desktopDescFontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),

              // Hackathon Project List
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(projects.length, (index) {
                    final item = projects[index];
                    final bool isSelected = _selectedIndex == index;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == projects.length - 1 ? 0 : 12,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColor.white.withValues(alpha: 0.14)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? AppColor.white.withValues(alpha: 0.25)
                                  : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Thumbnail
                              if (item.overviewImage != null &&
                                  item.overviewImage!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    item.overviewImage![0],
                                    width: 56,
                                    height: 72,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              const SizedBox(width: 14),

                              // Project Name & Award Subtitle
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppColor.white
                                            : AppColor.light.withValues(
                                                alpha: 0.75,
                                              ),
                                        fontFamily: 'Open Sans',
                                        fontSize: 16,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                      ),
                                    ),
                                    if (item.award != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        item.award!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: isSelected
                                              ? const Color(0xFFFFD700)
                                              : AppColor.light.withValues(
                                                  alpha: 0.5,
                                                ),
                                          fontFamily: 'Open Sans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileCarousel({
    required BuildContext context,
    required List<ProjectModel> projects,
    required double screenWidth,
  }) {
    final isSmallScreen = ResponsiveWidget.isSmallScreen(context);

    return SizedBox(
      width: screenWidth,
      height: isSmallScreen ? 570 : 600,
      child: PageView.builder(
        controller: _mobilePageController,
        clipBehavior: Clip.none,
        itemCount: projects.length,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final project = projects[index];
          final bool isSelected = _selectedIndex == index;

          return AnimatedScale(
            scale: isSelected ? 1.0 : 0.94,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            child: GestureDetector(
              onTap: () {
                if (!isSelected) {
                  _mobilePageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeOutCubic,
                  );
                } else {
                  context.push('/project_detail', extra: project);
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppFormat.primaryBorderRadius,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColor.shadow.withValues(
                        alpha: isSelected ? 0.28 : 0.16,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isSelected
                            ? AppColor.white.withValues(alpha: 0.3)
                            : AppColor.disable.withValues(alpha: 0.2),
                        width: isSelected ? 1.4 : 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Image
                        if (project.overviewImage != null &&
                            project.overviewImage!.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppFormat.primaryBorderRadius,
                            ),
                            child: SizedBox(
                              height: isSmallScreen ? 260 : 300,
                              width: double.infinity,
                              child: ImageSlider(
                                images: project.overviewImage!,
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),

                        // Project Info
                        Expanded(
                          child: _buildProjectInfo(
                            project: project,
                            isDesktop: false,
                            isMobile: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectInfo({
    required ProjectModel project,
    required bool isDesktop,
    required bool isMobile,
    double? titleFontSize,
    double? typeFontSize,
    double? descFontSize,
  }) {
    final double computedTitleSize = titleFontSize ?? (isMobile ? 24 : 36);
    final double computedTypeSize = typeFontSize ?? (isMobile ? 16 : 20);
    final double computedDescSize = descFontSize ?? (isMobile ? 13 : 14);

    return Column(
      mainAxisAlignment: isMobile
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Event Name
        if (project.eventName != null)
          Text(
            project.eventName!.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.white,
              fontFamily: 'Oswald',
              fontSize: isMobile ? 13 : 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        const SizedBox(height: 4),

        // Project Title
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          runSpacing: 2,
          children: [
            Text(
              project.name,
              style: TextStyle(
                color: AppColor.white,
                fontFamily: 'Racing Sans One',
                fontSize: computedTitleSize,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
            if (project.teamName != null) ...[
              Text(
                '-',
                style: TextStyle(
                  color: AppColor.light,
                  fontSize: computedTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                project.teamName!,
                style: TextStyle(
                  color: AppColor.white,
                  fontFamily: 'Racing Sans One',
                  fontSize: computedTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),

        // Project Award
        if (project.award != null) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/trophy.webp',
                width: isMobile ? 16 : 20,
                height: isMobile ? 16 : 20,
                color: const Color(0xFFFFD700),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  project.award!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFFFFD700),
                    fontFamily: 'Questrial',
                    fontSize: isMobile ? 16 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],

        // Project Type
        Text(
          project.type,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColor.light,
            fontFamily: 'Oswald',
            fontSize: computedTypeSize,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 20),

        // Description
        Text(
          project.description,
          maxLines: isMobile ? 4 : 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColor.light,
            fontFamily: 'Open Sans',
            fontSize: computedDescSize,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
