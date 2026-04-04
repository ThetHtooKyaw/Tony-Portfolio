import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_carousel/flutter_3d_carousel.dart';
import 'package:tony_portfolio/core/data/certificate_info.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/home/widgets/responsive_widget.dart';

class AwardMajorCertificateSection extends StatefulWidget {
  final ScrollController scrollController;
  const AwardMajorCertificateSection({
    super.key,
    required this.scrollController,
  });

  @override
  State<AwardMajorCertificateSection> createState() =>
      _AwardMajorCertificateSectionState();
}

class _AwardMajorCertificateSectionState
    extends State<AwardMajorCertificateSection> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isTablet = ResponsiveWidget.isTablet(context);
    final largeScreen = isDesktop || isTablet;

    return Container(
      height: screenSize.height,
      width: screenSize.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.4, 1.0],
          colors: [
            AppColor.white,
            Color.lerp(AppColor.white, AppColor.background, 0.5)!,
            AppColor.background,
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Label
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppFormat.priamaryPadding,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColor.background.withValues(alpha: 0.6),
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: AutoSizeText(
              'BEYOND THE CODE',
              maxFontSize: 20,
              minFontSize: 16,
              style: TextStyle(
                fontFamily: 'Questrial',
                color: AppColor.white,
                fontSize: screenSize.width * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: largeScreen
                  ? (screenSize.width * 0.03).clamp(40.0, 80.0)
                  : AppFormat.priamaryPadding,
            ),
            child: AutoSizeText(
              'Credentials & Credits',
              maxFontSize: 100,
              minFontSize: 30,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Racing Sans One',
                color: AppColor.background,
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
              'Where academic rigor meets professional practice and specialized innovation',
              maxFontSize: 20,
              minFontSize: 8,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Questrial',
                color: AppColor.shadow,
                fontSize: screenSize.width * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: largeScreen ? 0 : 40),

          // Major Certificates
          ClipRect(
            child: CarouselWidget3D(
              childScale: largeScreen ? 0.7 : 0.9,
              radius: largeScreen
                  ? screenSize.width * 0.7
                  : screenSize.width * 0.7,
              snapTimeInMillis: 200,
              shouldRotate: false,
              spinWhileRotating: false,
              dragSensitivity: 1.0,
              children: List.generate(majorCertificateInfos.length, (index) {
                return CarouselChild(
                  child: Container(
                    height: (screenSize.width).clamp(300, 600),
                    width: (screenSize.width).clamp(800, 1000),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.background, width: 2),
                    ),
                    child: Image.asset(
                      majorCertificateInfos[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
