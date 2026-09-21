import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PillContainerDownloadCount extends StatelessWidget {
  final int? downloadCount;
  final double fontSize;
  const PillContainerDownloadCount({
    super.key,
    this.downloadCount = 0,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColor.shadow.withValues(alpha: 0.2),
        border: Border.all(
          color: AppColor.accent.withValues(alpha: 0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppFormat.secondaryBorderRadius),
      ),
      child: Text(
        "${downloadCount}K+",
        style: TextStyle(
          fontFamily: 'Oswald',
          color: AppColor.accent,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PillContainerLabel extends StatelessWidget {
  final List<String> labels;
  const PillContainerLabel({super.key, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: labels.map((label) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: BorderRadius.circular(AppFormat.circleBorderRadius),
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
    );
  }
}

class PillContainerButton extends StatefulWidget {
  final List<Map<String, dynamic>> buttons;
  final Color buttonColor;
  final bool isDetailButton;
  const PillContainerButton({
    super.key,
    required this.buttons,
    required this.buttonColor,
    this.isDetailButton = false,
  });

  @override
  State<PillContainerButton> createState() => _PillContainerButtonState();
}

class _PillContainerButtonState extends State<PillContainerButton> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveWidget.isDesktop(context);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: widget.buttons.asMap().entries.map((entry) {
        final index = entry.key;
        final button = entry.value;

        final pill = GestureDetector(
          onTap: () {
            final url = button['url'] as String;
            launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              color: widget.isDetailButton
                  ? _hoveredIndex == index
                        ? AppColor.accent
                        : AppColor.white
                  : AppColor.background,
              borderRadius: BorderRadius.circular(AppFormat.circleBorderRadius),
              border: Border.all(
                color: widget.isDetailButton
                    ? _hoveredIndex == index
                          ? AppColor.accent
                          : AppColor.white
                    : _hoveredIndex == index
                    ? AppColor.accent
                    : AppColor.disable,
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  button['name'] as String,
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    color: widget.isDetailButton
                        ? _hoveredIndex == index
                              ? AppColor.white
                              : AppColor.background
                        : _hoveredIndex == index
                        ? AppColor.accent
                        : AppColor.light,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),

                Image.asset(
                  'assets/icons/open.webp',
                  width: 16,
                  height: 16,
                  color: widget.isDetailButton
                      ? _hoveredIndex == index
                            ? AppColor.white
                            : AppColor.background
                      : _hoveredIndex == index
                      ? AppColor.accent
                      : AppColor.light,
                ),
              ],
            ),
          ),
        );

        if (isDesktop) {
          return MouseRegion(
            onEnter: (_) => setState(() => _hoveredIndex = index),
            onExit: (_) => setState(() => _hoveredIndex = null),
            child: pill,
          );
        }

        return pill;
      }).toList(),
    );
  }
}
