import 'package:flutter/material.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/bottom_bar.dart';
import '../../../core/widgets/floating_btn.dart';
import '../../../core/widgets/title_widget.dart';
import '../models/experiment_project_model.dart';
import '../widgets/experiment_project_card.dart';

class ExperimentsView extends StatefulWidget {
  const ExperimentsView({super.key});

  @override
  State<ExperimentsView> createState() => _ExperimentsViewState();
}

class _ExperimentsViewState extends State<ExperimentsView>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

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
                subtitle: 'SLIDE OR SCROLL TO BROWSE PROJECTS',
                color: AppColor.light,
              ),

              // Title
              TitleWidget(title: 'Experiments', color: AppColor.accent),
              const SizedBox(height: 20),

              // Subtitle
              SubTitleWidget(
                subtitle:
                    'A collection of mini-apps, UI experiments, and hands-on learning builds',
                color: AppColor.white,
              ),
              SizedBox(height: 40),

              // Experiment Projects
              ...experimentProjects.asMap().entries.map((entry) {
                final index = entry.key;
                final project = entry.value;

                return ExperimentProjectCard(index: index, project: project);
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
