import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tony_portfolio/core/data/certificate_info.dart';
import 'package:tony_portfolio/src/award/views/award_major_certificate_section.dart';
import 'package:tony_portfolio/src/award/views/award_landing_section.dart';
import 'package:tony_portfolio/src/award/views/award_minor_certificate_section.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';
import 'package:tony_portfolio/src/widgets/app_bar.dart';
import 'package:tony_portfolio/src/widgets/bottom_bar.dart';
import 'package:tony_portfolio/src/widgets/floating_btn.dart';

class AwardView extends StatefulWidget {
  const AwardView({super.key});

  @override
  State<AwardView> createState() => AwardViewState();
}

class AwardViewState extends State<AwardView> {
  late ScrollController _scrollController;
  bool _canScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _canScroll = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isSmallMobile = ResponsiveWidget.isSmallMobile(context);
    final isMobile = ResponsiveWidget.isMobile(context);

    if (isMobile || isSmallMobile) {
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingBtn(
        scrollController: _scrollController,
        delay: Duration(milliseconds: 600),
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
                // Award Section
                AwardLandingSection(scrollController: _scrollController),

                // AppBar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: buildAppBar(context: context, screenSize: screenSize),
                ),
              ],
            ),
          ),

          // Major Certificate Section
          SliverToBoxAdapter(
            child: AwardMajorCertificateSection(
              scrollController: _scrollController,
            ),
          ),

          // Minor Certificate Section
          SliverToBoxAdapter(child: AwardMinorCertificateSection()),

          // Bottom Bar
          SliverToBoxAdapter(
            child: BottomBar(scrollController: _scrollController),
          ),
        ],
      ),
    );
  }
}
