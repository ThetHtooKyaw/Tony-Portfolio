import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/award/widgets/animated_certificate_card.dart';
import 'package:tony_portfolio/src/widgets/app_bar.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';

class CertificateDetailView extends StatefulWidget {
  final List<Map<String, dynamic>> certificates;
  const CertificateDetailView({super.key, required this.certificates});

  @override
  State<CertificateDetailView> createState() => _CertificateDetailViewState();
}

class _CertificateDetailViewState extends State<CertificateDetailView> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: buildAppBar(context: context, screenSize: screenSize),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop
                  ? AppFormat.priamaryPadding
                  : (screenSize.width * 0.1).clamp(
                      AppFormat.priamaryPadding,
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

              itemCount: widget.certificates.length,
              itemBuilder: (context, index) {
                final certificate = widget.certificates[index];

                return AnimatedCertificateCard(
                  index: index,
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
        ),
      ),
    );
  }
}
