import 'package:flutter/material.dart';

import '../../../core/model/project_model.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/bottom_bar.dart';
import '../../../core/widgets/floating_btn.dart';
import '../../../core/widgets/title_widget.dart';
import '../widgets/project_card.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({super.key});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final products = allProjects
        .where((p) => p.categories.contains('Production'))
        .toList();

    return Scaffold(
      appBar: buildAppBar(context: context, screenSize: screenSize),
      floatingActionButton: FloatingBtn(
        scrollController: _scrollController,
        delay: Duration(milliseconds: 0),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppFormat.primaryPadding,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Instruction
              SubTitleWidget(
                subtitle: 'SELECT TO VIEW PROJECT DETAILS',
                color: AppColor.light,
              ),

              // Title
              TitleWidget(title: 'Projects', color: AppColor.accent),
              const SizedBox(height: 20),

              // Subtitle
              SubTitleWidget(
                subtitle:
                    'Production-ready applications built for real-world impact and active users',
                color: AppColor.white,
              ),
              SizedBox(height: 40),

              // Experiment Projects
              ...products.asMap().entries.map((entry) {
                final index = entry.key;
                final project = entry.value;

                return ProjectCard(index: index, project: project);
              }),

              // Bottom Bar
              BottomBar(
                scrollController: _scrollController,
                isDetailView: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
