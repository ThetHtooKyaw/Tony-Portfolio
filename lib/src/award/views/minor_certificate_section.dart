import 'package:flutter/material.dart';
import 'package:tony_portfolio/src/award/model/certificate_model.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/award/widgets/animated_certificate_card.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:tony_portfolio/src/widgets/title_widget.dart';

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
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isTablet = ResponsiveWidget.isTablet(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppFormat.primaryPadding),
      width: double.infinity,
      child: Column(
        children: [
          // Instruction
          SubTitleWidget(
            subtitle: 'CLICK OR HOVER TO EXPAND DETAILS',
            color: AppColor.light,
          ),

          // Title
          TitleWidget(title: 'Language & Logic', color: AppColor.accent),
          const SizedBox(height: 20),

          // Subtitle
          SubTitleWidget(
            subtitle:
                'Verified proficiency in programming syntax and professional communication',
            color: AppColor.white,
          ),
          SizedBox(height: 60),

          // Minor Certificates List
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isTablet ? 600 : double.infinity,
              ),
              child: SizedBox(
                height: isDesktop ? 500 : null,
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
                          _expandedIndex = _expandedIndex == index
                              ? null
                              : index;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
