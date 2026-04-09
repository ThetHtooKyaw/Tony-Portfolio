import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/data/experience_info.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/home/widgets/animated_experience_card.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';

class HomeExperienceSection extends StatefulWidget {
  final ScrollController scrollController;
  const HomeExperienceSection({super.key, required this.scrollController});

  @override
  State<HomeExperienceSection> createState() => _HomeExperienceSectionState();
}

class _HomeExperienceSectionState extends State<HomeExperienceSection> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isLargeScreen = ResponsiveWidget.isLargeScreen(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: isLargeScreen ? 40 : AppFormat.priamaryPadding,
      ),
      width: double.infinity,
      color: AppColor.background,
      child: AnimatedBuilder(
        animation: widget.scrollController,
        builder: (context, child) {
          double scrollOffset = 0.0;

          if (widget.scrollController.hasClients) {
            scrollOffset = widget.scrollController.offset;
          }

          final double expLineTriggerPoint = screenSize.height * 1.25;
          final double scrollDistance = scrollOffset - expLineTriggerPoint;
          final double lineProgressSpeed = 0.7;
          final double expLine = (scrollDistance * lineProgressSpeed).clamp(
            0.0,
            double.infinity,
          );

          return Stack(
            alignment: Alignment.center,
            children: [
              // Experience Line
              Positioned(
                top: 0,
                child: Container(
                  height: expLine,
                  width: 4,
                  color: AppColor.accent,
                ),
              ),

              // Experience Dots
              Positioned(
                top: expLine,
                child: Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: AppColor.accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.accent,
                        blurRadius: 20,
                        spreadRadius: 4,
                        offset: Offset.zero,
                      ),
                    ],
                  ),
                ),
              ),

              // Experience List
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 60),

                    ...expInfos.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> expData = entry.value;

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: isDesktop
                              ? (screenSize.width * 0.08).clamp(80.0, 120.0)
                              : 60.0,
                        ),
                        child: AnimatedExperienceCard(
                          index: index,
                          expData: expData,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
