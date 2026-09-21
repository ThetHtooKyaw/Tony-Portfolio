import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:tony_portfolio/src/experiments/models/experiment_project_model.dart';
import 'package:tony_portfolio/src/widgets/app_bar.dart';
import 'package:tony_portfolio/src/widgets/bottom_bar.dart';
import 'package:tony_portfolio/src/widgets/floating_btn.dart';
import 'package:tony_portfolio/src/widgets/list_widget.dart';
import 'package:tony_portfolio/src/widgets/pill_container.dart';
import 'package:tony_portfolio/src/widgets/title_widget.dart';

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
    final isDesktop = ResponsiveWidget.isDesktop(context);

    return Scaffold(
      appBar: buildAppBar(context: context, screenSize: screenSize),
      floatingActionButton: FloatingBtn(
        scrollController: _scrollController,
        delay: Duration(milliseconds: 0),
        notScrollable: true,
      ),
      body: isDesktop
          ? _buildTemporaryLayout(isDesktop)
          : SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppFormat.primaryPadding,
                ),
                child: _buildTemporaryLayout(isDesktop),
              ),
            ),
    );
  }

  Widget _buildTemporaryLayout(bool isDesktop) {
    return Column(
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
              'A playground for experimental apps, interactive UI, and live feature prototypes',
          color: AppColor.white,
        ),
        SizedBox(height: 40),

        // Experiment Projects
        ...experimentProjects.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;

          return ExperimentProjectCard(index: index, project: project);
        }),
        if (isDesktop) const Spacer(),

        // Bottom Bar
        BottomBar(scrollController: _scrollController, isDetailView: true),
      ],
    );
  }
}

class ExperimentProjectCard extends StatefulWidget {
  final int index;
  final ExperimentProjectModel project;
  const ExperimentProjectCard({
    super.key,
    required this.index,
    required this.project,
  });

  @override
  State<ExperimentProjectCard> createState() => _ExperimentProjectCardState();
}

class _ExperimentProjectCardState extends State<ExperimentProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final project = widget.project;

    final card = AnimatedContainer(
      transform: Matrix4.translationValues(0, _isHovering ? -5.0 : 0, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: AppFormat.secondaryPadding),
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

          // Project Highlights
          ListWidget(title: 'HIGHLIGHTS', items: project.highlight),
          const SizedBox(height: 20),

          Divider(color: AppColor.disable, thickness: 0.5),
          const SizedBox(height: 20),

          // Project Buttons
          PillContainerButton(
            buttons: project.storeButtons,
            buttonColor: AppColor.background,
          ),
        ],
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
}
