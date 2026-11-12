import 'package:flutter/material.dart';

import '../../../core/model/project_model.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';
import '../../../core/utils/responsive_widget.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/bottom_bar.dart';
import '../../../core/widgets/floating_btn.dart';
import '../../../core/widgets/list_widget.dart';
import '../../../core/widgets/pill_container.dart';

class ProjectDetailView extends StatefulWidget {
  final ProjectModel project;
  const ProjectDetailView({super.key, required this.project});

  @override
  State<ProjectDetailView> createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends State<ProjectDetailView> {
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
    final isMobile = ResponsiveWidget.isMobile(context);
    final project = widget.project;

    return Scaffold(
      appBar: buildAppBar(context: context, screenSize: screenSize),
      floatingActionButton: FloatingBtn(
        scrollController: _scrollController,
        delay: Duration(milliseconds: 0),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: AppFormat.primaryPadding,
                  horizontal: AppFormat.primaryPadding,
                ),
                width: isDesktop ? 900 : double.infinity,
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
                                widget.project.name,
                                style: TextStyle(
                                  fontFamily: 'Racing Sans One',
                                  color: AppColor.white,
                                  fontSize: isMobile ? 30 : 40,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Project Type
                              Text(
                                project.type!,
                                style: TextStyle(
                                  fontFamily: 'Oswald',
                                  color: AppColor.light,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),

                          // Project Download Count
                          if (project.downloadCount! > 0)
                            PillContainerDownloadCount(
                              downloadCount: widget.project.downloadCount,
                              fontSize: 20.0,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Project Labels
                    PillContainerLabel(labels: widget.project.labels),
                    const SizedBox(height: 40),

                    // Project Image
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobileView = constraints.maxWidth < 500;
                        final itemWidth = isMobileView
                            ? constraints.maxWidth
                            : (constraints.maxWidth -
                                      AppFormat.primaryPadding) /
                                  2;

                        return Wrap(
                          spacing: AppFormat.primaryPadding,
                          runSpacing: AppFormat.primaryPadding,
                          children: widget.project.images.map((image) {
                            return SizedBox(
                              width: itemWidth.clamp(0.0, constraints.maxWidth),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 600,
                                  minHeight: 200,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppFormat.primaryBorderRadius,
                                    ),
                                    border: Border.all(
                                      color: AppColor.disable,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      AppFormat.primaryBorderRadius,
                                    ),
                                    child: Image.asset(
                                      image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 40),

                    // Project Overview
                    Text(
                      'OVERVIEW',
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        color: AppColor.accent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      project.description!,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        color: AppColor.light,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Project Features
                    ListWidget(
                      title: 'PROJECT FEATURES',
                      items: widget.project.features,
                    ),
                    const SizedBox(height: 40),

                    // What I Learned
                    if (project.detail != null) ...[
                      ListWidget(
                        title: 'WHAT I LEARNED',
                        items: widget.project.learned,
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Project Detail
                    if (project.detail != null) ...[
                      const SizedBox(height: 20),

                      Text(
                        'DETAIL',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          color: AppColor.accent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        project.detail!,
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          color: AppColor.light,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    Divider(color: AppColor.disable, thickness: 0.5),
                    const SizedBox(height: 20),

                    // Project Buttons
                    PillContainerButton(
                      buttons: project.storeButtons!,
                      buttonColor: AppColor.accent,
                      isDetailButton: true,
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Bar
            BottomBar(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}
