import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/model/project_model.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';
import '../../../core/utils/responsive_widget.dart';
import '../../../core/widgets/pill_container.dart';

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
      duration: const Duration(milliseconds: 400),
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
          if (_controller.status == AnimationStatus.dismissed) {
            _controller.forward();
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
      onTap: () => context.push('/project_detail', extra: project),
      child: AnimatedContainer(
        transform: Matrix4.translationValues(0, _isHovering ? -5.0 : 0, 0),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(
          vertical: AppFormat.secondaryPadding,
        ),
        padding: const EdgeInsets.all(AppFormat.primaryPadding),
        width: isDesktop ? 900 : double.infinity,
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
                          color: _isHovering ? AppColor.accent : AppColor.white,
                          fontSize: 28,
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
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),

                  // Project Download Count
                  if (project.downloadCount != null &&
                      project.downloadCount! > 0)
                    PillContainerAppUsedCount(
                      text: "${project.downloadCount}+",
                      fontSize: 16.0,
                    ),

                  // Project Play Count
                  if (project.playCount != null)
                    PillContainerAppUsedCount(
                      text: "${project.playCount}+",
                      fontSize: 16.0,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Project Labels
            PillContainerLabel(labels: project.techStack),
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
            PillContainerButton(
              buttons: project.storeButtons,
              buttonColor: AppColor.background,
            ),
          ],
        ),
      ),
    );
  }
}
