import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_carousel/flutter_3d_carousel.dart';
import 'package:tony_portfolio/src/award/model/certificate_model.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:tony_portfolio/src/widgets/title_widget.dart';

class MajorCertificateSection extends StatelessWidget {
  final ScrollController scrollController;
  const MajorCertificateSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isLargeScreen = ResponsiveWidget.isLargeScreen(context);

    return Container(
      padding: EdgeInsets.only(top: AppFormat.primaryPadding, bottom: 40),
      width: double.infinity,
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
          // Label
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppFormat.primaryPadding,
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

          // Instruction
          SubTitleWidget(
            subtitle: 'CLICK TO VIEW ANIMATED',
            color: AppColor.shadow,
          ),

          // Title
          TitleWidget(
            title: 'Credentials & Credits',
            color: AppColor.background,
          ),
          const SizedBox(height: 20),

          // Subtitle
          SubTitleWidget(
            subtitle:
                'Where academic rigor meets professional practice and specialized innovation',
            color: AppColor.shadow,
          ),
          SizedBox(height: isLargeScreen ? 0 : 40),

          // Major Certificates
          ClipRect(
            child: CarouselWidget3D(
              childScale: isLargeScreen ? 0.7 : 0.9,
              radius: isLargeScreen
                  ? screenSize.width * 0.7
                  : screenSize.width * 0.7,
              snapTimeInMillis: 200,
              shouldRotate: false,
              spinWhileRotating: false,
              dragSensitivity: 1.0,
              children: List.generate(majorCertificates.length, (index) {
                return CarouselChild(
                  child: Container(
                    height: (screenSize.width).clamp(300, 600),
                    width: (screenSize.width).clamp(800, 1000),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.background, width: 2),
                    ),
                    child: Image.asset(
                      majorCertificates[index],
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
