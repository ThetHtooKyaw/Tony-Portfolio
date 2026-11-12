import 'package:flutter/material.dart';

import '../../../core/model/project_model.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';
import '../../../core/utils/responsive_widget.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/bottom_bar.dart';
import '../../../core/widgets/floating_btn.dart';
import '../../../core/widgets/title_widget.dart';
import '../widgets/experiment_project_card.dart';

class ExperimentView extends StatefulWidget {
  const ExperimentView({super.key});

  @override
  State<ExperimentView> createState() => _ExperimentViewState();
}

class _ExperimentViewState extends State<ExperimentView> {
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
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final products = allProjects
        .where((p) => p.categories.contains('Experiment'))
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
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 900 : double.infinity,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = isDesktop
                          ? (constraints.maxWidth - 20) / 2
                          : constraints.maxWidth;

                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: products.asMap().entries.map((entry) {
                          final index = entry.key;
                          final project = entry.value;

                          return SizedBox(
                            width: itemWidth.clamp(0.0, constraints.maxWidth),
                            child: ExperimentProjectCard(
                              index: index,
                              project: project,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),

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
