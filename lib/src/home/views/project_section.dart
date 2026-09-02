import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tony_portfolio/src/home/models/project_model.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppFormat.primaryPadding),
      child: Column(
        children: [
          const SizedBox(height: 20),

          ...projects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;

            return ProjectCard(index: index, project: project);
          }),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final int index;
  final ProjectModel project;
  const ProjectCard({super.key, required this.index, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideUpAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _slideUpAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final project = widget.project;

    final card = VisibilityDetector(
      key: Key('project-${widget.index}'),
      onVisibilityChanged: (expCard) {
        if (!mounted) return;

        if (expCard.visibleFraction > 0.03) {
          if (_controller.status == AnimationStatus.dismissed ||
              _controller.status == AnimationStatus.reverse) {
            _controller.forward();
          }
        } else if (expCard.visibleFraction == 0) {
          if (isDesktop) {
            _controller.reset();
          }
        }
      },
      child: FadeTransition(
        opacity: _fadeInAnimation,
        child: SlideTransition(
          position: _slideUpAnimation,
          child: _buildProjectCard(context, isDesktop, project),
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

  GestureDetector _buildProjectCard(
    BuildContext context,
    bool isDesktop,
    ProjectModel project,
  ) {
    return GestureDetector(
      onTap: () => context.go('/project_detail', extra: widget.project),
      child: Center(
        child: AnimatedContainer(
          transform: Matrix4.translationValues(0, _isHovering ? -5.0 : 0, 0),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: isDesktop ? 900 : double.infinity,
          margin: const EdgeInsets.symmetric(
            vertical: AppFormat.secondaryPadding,
          ),
          padding: const EdgeInsets.all(AppFormat.primaryPadding),
          decoration: BoxDecoration(
            color: AppColor.card,
            border: Border.all(color: AppColor.disable, width: 0.5),
            borderRadius: BorderRadius.circular(AppFormat.primaryBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: AppFormat.primaryPadding,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Name
                        Text(
                          project.name,
                          style: TextStyle(
                            fontFamily: 'Racing Sans One',
                            color: _isHovering
                                ? AppColor.accent
                                : AppColor.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Project Type
                        Text(
                          project.type,
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            color: AppColor.light,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    // Project Download Count
                    if (project.downloadCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.shadow.withValues(alpha: 0.2),
                          border: Border.all(
                            color: AppColor.accent.withValues(alpha: 0.3),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(
                            AppFormat.circleBorderRadius,
                          ),
                        ),
                        child: Text(
                          "${project.downloadCount}K+",
                          style: const TextStyle(
                            fontFamily: 'Oswald',
                            color: AppColor.accent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Project Labels
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: project.labels.map((label) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: BorderRadius.circular(
                        AppFormat.circleBorderRadius,
                      ),
                      border: Border.all(color: AppColor.disable, width: 0.5),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        color: AppColor.light,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Project Description
              Text(
                project.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColor.light, fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Project Buttons
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: project.storeButtons.map((button) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: BorderRadius.circular(
                        AppFormat.circleBorderRadius,
                      ),
                      border: Border.all(color: AppColor.disable, width: 0.5),
                    ),
                    child: Text(
                      button['name'] as String,
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        color: AppColor.white,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
