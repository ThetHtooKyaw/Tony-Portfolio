import 'package:flutter/material.dart';

import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/bottom_bar.dart';
import '../../../core/widgets/floating_btn.dart';
import 'landing_section.dart';
import 'major_certificate_section.dart';
import 'minor_certificate_section.dart';

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
                LandingSection(scrollController: _scrollController),

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
            child: MajorCertificateSection(scrollController: _scrollController),
          ),

          // Minor Certificate Section
          SliverToBoxAdapter(child: MinorCertificateSection()),

          // Bottom Bar
          SliverToBoxAdapter(
            child: BottomBar(scrollController: _scrollController),
          ),
        ],
      ),
    );
  }
}
