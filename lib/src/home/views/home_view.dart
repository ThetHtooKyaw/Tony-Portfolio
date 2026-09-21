import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/src/widgets/app_bar.dart';
import 'package:tony_portfolio/src/home/views/experience_section.dart';
import 'package:tony_portfolio/src/home/views/intro_section.dart';
import 'package:tony_portfolio/src/home/views/landing_section.dart';
import 'package:tony_portfolio/src/home/views/project_section.dart';
import 'package:tony_portfolio/src/home/widgets/sticky_section_header.dart';
import 'package:tony_portfolio/src/widgets/bottom_bar.dart';
import 'package:tony_portfolio/src/widgets/floating_btn.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  bool _canScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    Future.delayed(const Duration(milliseconds: 2800), () {
      setState(() {
        _canScroll = true;
      });
    });
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
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingBtn(
        scrollController: _scrollController,
        delay: Duration(milliseconds: 1600),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: _canScroll
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Landing Section
                LandingSection(scrollController: _scrollController),

                // App Bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: buildAppBar(
                    context: context,
                    screenSize: screenSize,
                    isBlackBackground: false,
                  ),
                ),
              ],
            ),
          ),

          // Intro Section
          SliverMainAxisGroup(
            slivers: [
              // Header
              SliverPersistentHeader(
                pinned: true,
                delegate: StickySectionHeader(
                  title: "Intro",
                  screenWidth: screenSize.width,
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: IntroSection(scrollController: _scrollController),
              ),
            ],
          ),

          // Blank Space
          SliverToBoxAdapter(
            child: Container(
              height: 10,
              width: double.infinity,
              color: AppColor.background,
            ),
          ),

          // Experience Section
          SliverMainAxisGroup(
            slivers: [
              // Header
              SliverPersistentHeader(
                pinned: true,
                delegate: StickySectionHeader(
                  title: "My Experience",
                  screenWidth: screenSize.width,
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: ExperienceSection(scrollController: _scrollController),
              ),
            ],
          ),

          // Blank Space
          SliverToBoxAdapter(
            child: Container(
              height: 10,
              width: double.infinity,
              color: AppColor.background,
            ),
          ),

          // Project Section
          SliverMainAxisGroup(
            slivers: [
              // Header
              SliverPersistentHeader(
                pinned: true,
                delegate: StickySectionHeader(
                  title: "Projects",
                  screenWidth: screenSize.width,
                ),
              ),

              // Content
              SliverToBoxAdapter(child: ProjectSection()),
            ],
          ),

          // Bottom Bar
          SliverToBoxAdapter(
            child: BottomBar(scrollController: _scrollController),
          ),
        ],
      ),
    );
  }
}
