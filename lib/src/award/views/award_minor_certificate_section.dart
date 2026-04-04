import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/data/certificate_info.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/award/widgets/animated_certificate_card.dart';
import 'package:tony_portfolio/src/home/widgets/responsive_widget.dart';

class AwardMinorCertificateSection extends StatefulWidget {
  const AwardMinorCertificateSection({super.key});

  @override
  State<AwardMinorCertificateSection> createState() =>
      _AwardMinorCertificateSectionState();
}

class _AwardMinorCertificateSectionState
    extends State<AwardMinorCertificateSection> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isTablet = ResponsiveWidget.isTablet(context);
    final isSmallMobile = ResponsiveWidget.isSmallMobile(context);
    final largeScreen = isDesktop || isTablet;

    return Container(
      padding: const EdgeInsets.only(bottom: 40),
      width: screenSize.width,
      color: AppColor.background,
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: largeScreen
                  ? (screenSize.width * 0.03).clamp(40.0, 80.0)
                  : AppFormat.priamaryPadding,
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
              horizontal: largeScreen
                  ? (screenSize.width * 0.03).clamp(40.0, 80.0)
                  : AppFormat.priamaryPadding,
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

          // Minor Certificates Grid
          SizedBox(
            height: isDesktop
                ? screenSize.height * 1.4
                : isSmallMobile
                ? screenSize.height * 2.6
                : screenSize.height * 2.0,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: largeScreen
                    ? (screenSize.width * 0.1).clamp(80.0, 120.0)
                    : AppFormat.priamaryPadding,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 2 : 1,
                mainAxisSpacing: isDesktop
                    ? (screenSize.width * 0.06).clamp(100.0, 150.0)
                    : 40,
                crossAxisSpacing: isDesktop
                    ? (screenSize.width * 0.04).clamp(20.0, 120.0)
                    : 0.0,
                mainAxisExtent: isDesktop
                    ? (screenSize.width * 0.28).clamp(400, 550)
                    : (screenSize.width * 0.28).clamp(380, 480),
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: minorCertificateInfos.length,
              itemBuilder: (context, index) {
                final certificate = minorCertificateInfos[index];
                final bool isRightColumn = isDesktop && index % 2 != 0;

                return AnimatedCertificateCard(
                  index: index,
                  certificate: certificate,
                  isRightColumn: isRightColumn,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
