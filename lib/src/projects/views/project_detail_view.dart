import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/model/project_model.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';
import '../../../core/utils/responsive_widget.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/bottom_bar.dart';
import '../../../core/widgets/list_widget.dart';
import '../widgets/image_carousel.dart';
import '../widgets/image_slider.dart';

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
    final project = widget.project;

    return Scaffold(
      appBar: buildAppBar(context: context, screenSize: screenSize),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: isDesktop
            ? _buildDesktopLayout(project)
            : _buildMobileLayout(project),
      ),
    );
  }

  Widget _buildDesktopLayout(ProjectModel project) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final double horizontalPadding = (screenWidth * 0.07).clamp(60.0, 200.0);

    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Porject Image
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              widget.project.name,
              style: TextStyle(
                fontFamily: 'Racing Sans One',
                color: AppColor.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Project Type
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              project.type,
              style: TextStyle(
                fontFamily: 'Oswald',
                color: AppColor.light,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 40),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const double gap = 40.0;
                final double availableWidth = (constraints.maxWidth - gap)
                    .clamp(0.0, double.infinity);

                final double maxSidebarWidth = (availableWidth * 0.45) < 300.0
                    ? 300.0
                    : (availableWidth * 0.45);

                final double sidebarWidth = (availableWidth * 0.30).clamp(
                  300.0,
                  maxSidebarWidth,
                );

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Content
                    Expanded(child: _buildMainContent(project)),
                    const SizedBox(width: gap),

                    // Info Sidebar
                    SizedBox(
                      width: sidebarWidth,
                      child: _buildInfoSidebar(project),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 40),

          // Bottom Bar
          BottomBar(scrollController: _scrollController),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(ProjectModel project) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = ResponsiveWidget.isTablet(context);

    final double horizontalPadding = isTablet
        ? (screenWidth * 0.08).clamp(AppFormat.primaryPadding, 80.0)
        : AppFormat.primaryPadding;

    return Padding(
      padding: const EdgeInsets.only(top: AppFormat.primaryPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Porject Image
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              widget.project.name,
              style: TextStyle(
                fontFamily: 'Racing Sans One',
                color: AppColor.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Project Type
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              project.type,
              style: TextStyle(
                fontFamily: 'Oswald',
                color: AppColor.light,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Info Sidebar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: _buildInfoSidebar(project),
          ),
          const SizedBox(height: 40),

          // Main Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: _buildMainContent(project),
          ),
          const SizedBox(height: 20),

          // Bottom Bar
          BottomBar(scrollController: _scrollController),
        ],
      ),
    );
  }

  Widget _buildMainContent(ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Porject Image
        ImageCarousel(images: project.images),
        const SizedBox(height: 40),

        // Porject Summary
        Text(
          'DESCRIPTION',
          style: const TextStyle(
            fontFamily: 'Oswald',
            color: AppColor.accent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        // Team Overview
        Text(
          project.teamOverview,
          style: TextStyle(
            fontFamily: 'Open Sans',
            color: AppColor.light,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),

        // Project Description
        Text(
          project.description,
          style: TextStyle(
            fontFamily: 'Open Sans',
            color: AppColor.light,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 40),

        // Project Features
        ListWidget(title: 'PROJECT FEATURES', items: project.features),
      ],
    );
  }

  Widget _buildInfoSidebar(ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project Overview Image
        if (project.overviewImage != null &&
            project.overviewImage!.isNotEmpty) ...[
          ImageSlider(images: project.overviewImage!),
          const SizedBox(height: 40),
        ],

        // Project Buttons
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: project.storeButtons.length,
          itemBuilder: (context, index) {
            final button = project.storeButtons[index];
            final buttonName = button['name'];
            final buttonUrl = button['url'];

            return Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(buttonUrl),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.background,
                    padding: EdgeInsets.symmetric(
                      vertical: AppFormat.primaryPadding,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppFormat.secondaryBorderRadius,
                      ),
                    ),
                  ),
                  icon: Image.asset(button['icon'], width: 22, height: 22),
                  label: Text(
                    buttonName,
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),

        // Hackathon Info
        if (project.categories.contains('Hackathon')) ...[
          _buildInfoRow('EVENT', project.eventName),
          _buildInfoRow('TEAM', project.teamName),
          _buildInfoRow('AWARD', project.award),
        ],

        // Project Download & Play Count
        if (project.downloadCount != null && project.downloadCount! > 0)
          _buildInfoRow(
            'DOWNLOADS',
            project.downloadCount != null ? '${project.downloadCount}+' : 'N/A',
          ),

        if (project.playCount != null)
          _buildInfoRow(
            'PLAYS',
            project.playCount != null ? '${project.playCount}+' : 'N/A',
          ),

        // Project Platform
        _buildPlatformRow(project),
        const SizedBox(height: 10),

        Divider(color: AppColor.disable, thickness: 0.5),
        const SizedBox(height: 10),

        // Project Tech Stack
        _buildTechStackRow(project),

        // Project Presentation
        if (project.presentation != null) ...[_buildPresentationRow(project)],
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPlatformRow(ProjectModel project) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label
        Text(
          'PLATFORM',
          style: const TextStyle(
            fontFamily: 'Oswald',
            color: AppColor.accent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Platform Icons
        Row(
          children: project.platformIcons.map((iconPath) {
            return Padding(
              padding: const EdgeInsets.only(right: AppFormat.secondaryPadding),
              child: Image.asset(
                iconPath,
                width: 22,
                height: 22,
                color: AppColor.white,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTechStackRow(ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'TECH STACK',
          style: const TextStyle(
            fontFamily: 'Oswald',
            color: AppColor.accent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        // Tech Stack Labels
        Wrap(
          spacing: AppFormat.secondaryPadding,
          runSpacing: AppFormat.primaryPadding,
          children: project.techStack.map((tech) {
            return Container(
              padding: const EdgeInsets.all(AppFormat.primaryPadding),
              decoration: BoxDecoration(
                color: AppColor.card,
                borderRadius: BorderRadius.circular(
                  AppFormat.secondaryBorderRadius,
                ),
              ),
              child: Text(
                tech,
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  color: AppColor.white,
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),

        Divider(color: AppColor.disable, thickness: 0.5),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPresentationRow(ProjectModel project) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label
        Text(
          'PRESENTATION',
          style: const TextStyle(
            fontFamily: 'Oswald',
            color: AppColor.accent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Link Button
        GestureDetector(
          onTap: () {
            launchUrl(
              Uri.parse(project.presentation!),
              mode: LaunchMode.externalApplication,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: AppFormat.primaryPadding,
            ),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(
                AppFormat.secondaryBorderRadius,
              ),
            ),
            child: Text(
              'Click Here',
              style: const TextStyle(
                fontFamily: 'Open Sans',
                color: AppColor.background,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String? text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppFormat.secondaryPadding),
      child: Column(
        children: [
          Row(
            children: [
              // Label
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Oswald',
                    color: AppColor.accent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Text
              Expanded(
                child: Text(
                  text!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontFamily: 'Open Sans',
                    color: AppColor.light,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Divider(color: AppColor.disable, thickness: 0.5),
        ],
      ),
    );
  }
}
