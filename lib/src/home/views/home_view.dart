import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/src/home/views/home_appbar.dart';
import 'package:tony_portfolio/src/home/views/home_experience_section.dart';
import 'package:tony_portfolio/src/home/views/home_intro_section.dart';
import 'package:tony_portfolio/src/home/views/home_landing_section.dart';
import 'package:tony_portfolio/src/home/views/home_project_section.dart';
import 'package:tony_portfolio/src/home/widgets/sticky_section_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
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
      floatingActionButton: buildFloatingBtn(screenSize: screenSize),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Landing Section
                HomeLandingSection(scrollController: _scrollController),

                // App Bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: buildAppBar(context: context, screenSize: screenSize),
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
                child: HomeIntroSection(scrollController: _scrollController),
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
                child: HomeExperienceSection(
                  scrollController: _scrollController,
                ),
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
              SliverToBoxAdapter(
                child: HomeProjectSection(scrollController: _scrollController),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
