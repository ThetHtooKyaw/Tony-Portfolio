import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tony_portfolio/src/award/model/certificate_model.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/award/widgets/animated_certificate_card.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';

class MinorCertificateSection extends StatefulWidget {
  const MinorCertificateSection({super.key});

  @override
  State<MinorCertificateSection> createState() =>
      _MinorCertificateSectionState();
}

class _MinorCertificateSectionState extends State<MinorCertificateSection> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isLargeScreen = ResponsiveWidget.isLargeScreen(context);

    return Container(
      width: double.infinity,
      color: AppColor.background,
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isLargeScreen
                  ? (screenSize.width * 0.03).clamp(40.0, 80.0)
                  : AppFormat.primaryPadding,
            ),
            child: AutoSizeText(
              'Language & Logic',
              maxFontSize: 100,
              minFontSize: 30,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Racing Sans One',
                color: AppColor.accent,
                height: 1,
                fontSize: screenSize.width * 0.1,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Subtitle
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isLargeScreen
                  ? (screenSize.width * 0.03).clamp(40.0, 80.0)
                  : AppFormat.primaryPadding,
            ),
            child: AutoSizeText(
              'Verified proficiency in programming syntax and professional communication',
              maxFontSize: 20,
              minFontSize: 8,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Questrial',
                color: AppColor.light,
                fontSize: screenSize.width * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: isDesktop ? 100 : 60),

          // Minor Certificates List
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop
                  ? AppFormat.primaryPadding
                  : (screenSize.width * 0.1).clamp(
                      AppFormat.primaryPadding,
                      100.0,
                    ),
            ),
            height: isDesktop ? 500 : null,
            alignment: Alignment.center,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: 20, height: 20),
              scrollDirection: isDesktop ? Axis.horizontal : Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),

              itemCount: minorCertificates.length,
              itemBuilder: (context, index) {
                final certificate = minorCertificates[index];

                return AnimatedCertificateCard(
                  certificate: certificate,
                  isExpandedMobile: _expandedIndex == index,
                  onTapMobile: () {
                    setState(() {
                      if (_expandedIndex == index) {
                        _expandedIndex = null;
                      } else {
                        _expandedIndex = index;
                      }
                    });
                  },
                );
              },
            ),
          ),

          SizedBox(height: isLargeScreen ? 100 : 20),
        ],
      ),
    );
  }
}
