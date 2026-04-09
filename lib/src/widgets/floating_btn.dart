import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tony_portfolio/core/data/contact_info.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/home/widgets/blend_mask.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingBtn extends StatefulWidget {
  final ScrollController scrollController;
  final Duration delay;
  const FloatingBtn({
    super.key,
    required this.scrollController,
    required this.delay,
  });

  @override
  State<FloatingBtn> createState() => _FloatingBtnState();
}

class _FloatingBtnState extends State<FloatingBtn> {
  bool isNearBottom = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients) return;

    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    final remaining = maxScroll - currentScroll;

    if (remaining <= 50 && !isNearBottom) {
      setState(() {
        isNearBottom = true;
      });
    } else if (remaining > 50 && isNearBottom) {
      setState(() {
        isNearBottom = false;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isLargeScreen = ResponsiveWidget.isLargeScreen(context);
    final double iconSize = (screenSize.width * 0.05).clamp(20, 30);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.only(
        bottom: isNearBottom
            ? isLargeScreen
                  ? 100.0
                  : 80.0
            : 0,
      ),
      child:
          RepaintBoundary(
            child: BlendMask(
              blendMode: BlendMode.difference,
              child: Container(
                padding: EdgeInsets.all((screenSize.width * 0.01).clamp(0, 10)),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColor.white),
                  borderRadius: BorderRadius.circular(
                    AppFormat.circleBorderRadius,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: contactInfos.map((social) {
                    return IconButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(social['url']!);

                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        )) {
                          debugPrint('Could not launch ${social['url']}');
                        }
                      },
                      icon: Image.asset(
                        social['icon']!,
                        width: iconSize,
                        height: iconSize,
                        color: AppColor.white,
                      ),
                      tooltip: social['tooltip']!,
                    );
                  }).toList(),
                ),
              ),
            ),
          ).animate().slide(
            begin: const Offset(0.0, 1.2),
            end: Offset.zero,
            duration: 600.ms,
            delay: widget.delay,
            curve: Curves.easeIn,
          ),
    );
  }
}
