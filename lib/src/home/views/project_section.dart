import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/model/project_model.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';
import '../../projects/widgets/project_card.dart';
import '../../../core/widgets/title_widget.dart';
import '../widgets/view_all_button.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    final previewProjects = allProjects
        .where((p) => p.categories.contains('Production'))
        .take(2)
        .toList();

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
          ...previewProjects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;

            return ProjectCard(index: index, project: project);
          }),
          const SizedBox(height: 40),

          // View All Button
          ViewAllButton(onPressed: () => context.go('/projects')),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
