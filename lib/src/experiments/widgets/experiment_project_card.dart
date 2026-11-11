import 'package:flutter/material.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';
import '../../../core/utils/responsive_widget.dart';
import '../../../core/widgets/list_widget.dart';
import '../../../core/widgets/pill_container.dart';
import '../models/experiment_project_model.dart';

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
