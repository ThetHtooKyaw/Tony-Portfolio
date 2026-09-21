import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tony_portfolio/src/home/models/project_model.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:tony_portfolio/src/widgets/pill_container.dart';
import 'package:tony_portfolio/src/widgets/title_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppFormat.primaryPadding),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Instruction
          SubTitleWidget(
            subtitle: 'SELECT TO VIEW PROJECT DETAILS',
            color: AppColor.light,
          ),
          const SizedBox(height: 20),

          // Projects
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
      onTap: () => context.push('/project_detail', extra: widget.project),
      child: Center(
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
                            color: _isHovering
                                ? AppColor.accent
                                : AppColor.white,
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
                    if (project.downloadCount > 0)
                      PillContainerDownloadCount(
                        downloadCount: project.downloadCount,
                        fontSize: 16.0,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Project Labels
              PillContainerLabel(labels: project.labels),
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
      ),
    );
  }
}
