import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:tony_portfolio/src/home/models/project_model.dart';
import 'package:tony_portfolio/src/widgets/app_bar.dart';
import 'package:tony_portfolio/src/widgets/bottom_bar.dart';
import 'package:tony_portfolio/src/widgets/floating_btn.dart';
import 'package:tony_portfolio/src/widgets/list_widget.dart';
import 'package:tony_portfolio/src/widgets/pill_container.dart';

class ProjectDetailView extends StatefulWidget {
  final ProjectModel project;
  const ProjectDetailView({super.key, required this.project});

  @override
  State<ProjectDetailView> createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends State<ProjectDetailView>
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
    final isMobile = ResponsiveWidget.isMobile(context);

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
                                widget.project.type,
                                style: TextStyle(
                                  fontFamily: 'Oswald',
                                  color: AppColor.light,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),

                          // Project Download Count
                          if (widget.project.downloadCount > 0)
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
                    Wrap(
                      spacing: AppFormat.primaryPadding,
                      runSpacing: AppFormat.primaryPadding,
                      children: widget.project.images.map((image) {
                        return SizedBox(
                          width: 400,
                          height: 400,
                          child: Container(
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
                              child: Image.asset(image, fit: BoxFit.contain),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),

                    // Project Description
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
                      widget.project.description,
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
                    ListWidget(
                      title: 'WHAT I LEARNED',
                      items: widget.project.learned,
                    ),
                    const SizedBox(height: 40),

                    // Project Detail
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
                      widget.project.detail,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        color: AppColor.light,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Divider(color: AppColor.disable, thickness: 0.5),
                    const SizedBox(height: 20),

                    // Project Buttons
                    PillContainerButton(
                      buttons: widget.project.storeButtons,
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
