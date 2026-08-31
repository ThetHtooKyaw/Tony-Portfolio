import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:tony_portfolio/src/home/models/project_model.dart';
import 'package:tony_portfolio/src/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailView extends StatelessWidget {
  final ProjectModel project;
  const ProjectDetailView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isMobile = ResponsiveWidget.isMobile(context);

    return Scaffold(
      appBar: buildAppBar(context: context, screenSize: screenSize),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 40,
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
                            project.name,
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.shadow.withValues(alpha: 0.2),
                            border: Border.all(
                              color: AppColor.accent.withValues(alpha: 0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppFormat.secondaryBorderRadius,
                            ),
                          ),
                          child: Text(
                            "${project.downloadCount}K+",
                            style: const TextStyle(
                              fontFamily: 'Oswald',
                              color: AppColor.accent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Project Labels
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: project.labels.map((label) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.background,
                        borderRadius: BorderRadius.circular(
                          AppFormat.circleBorderRadius,
                        ),
                        border: Border.all(color: AppColor.disable, width: 0.5),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          color: AppColor.light,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),

                // Project Image
                Wrap(
                  spacing: AppFormat.primaryPadding,
                  runSpacing: AppFormat.primaryPadding,
                  children: project.images.map((image) {
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
                  project.description,
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: AppColor.light,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),

                // Project Features
                Text(
                  'KEY FEATURES',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    color: AppColor.accent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: project.features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: AppColor.accent,
                          ),
                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                fontFamily: 'Open Sans',
                                color: AppColor.light,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),

                // What I Learned
                Text(
                  'WHAT I LEARNED',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    color: AppColor.accent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: project.learned.map((learned) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: AppColor.accent,
                          ),
                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              learned,
                              style: const TextStyle(
                                fontFamily: 'Open Sans',
                                color: AppColor.light,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
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
                  project.detail,
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: AppColor.light,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),

                Divider(color: AppColor.disable, thickness: 0.5),
                const SizedBox(height: 20),

                // Project Buttons
                Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: project.storeButtons.map((button) {
                    return ElevatedButton(
                      onPressed: () async {
                        final url = button['url'] as String;
                        await launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 16,
                        ),
                        foregroundColor: AppColor.background,
                        backgroundColor: AppColor.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            button['name'] as String,
                            style: const TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),

                          Icon(Icons.open_in_new, size: 20),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
