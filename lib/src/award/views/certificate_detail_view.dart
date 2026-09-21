import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/award/model/certificate_model.dart';
import 'package:tony_portfolio/src/award/widgets/animated_certificate_card.dart';
import 'package:tony_portfolio/src/widgets/app_bar.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:tony_portfolio/src/widgets/bottom_bar.dart';
import 'package:tony_portfolio/src/widgets/floating_btn.dart';
import 'package:tony_portfolio/src/widgets/title_widget.dart';

class CertificateDetailView extends StatefulWidget {
  final String title;
  final List<MinorCertificateModel> certificates;
  const CertificateDetailView({
    super.key,
    required this.title,
    required this.certificates,
  });

  @override
  State<CertificateDetailView> createState() => _CertificateDetailViewState();
}

class _CertificateDetailViewState extends State<CertificateDetailView>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);

    return Scaffold(
      appBar: buildAppBar(context: context, screenSize: screenSize),
      floatingActionButton: FloatingBtn(
        scrollController: _scrollController,
        delay: Duration(milliseconds: 0),
        notScrollable: true,
      ),
      body: isDesktop
          ? _buildDetailCertificateCard(isDesktop)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppFormat.primaryPadding,
                ),
                child: _buildDetailCertificateCard(isDesktop),
              ),
            ),
    );
  }

  Widget _buildDetailCertificateCard(bool isDesktop) {
    final isTablet = ResponsiveWidget.isTablet(context);

    return Column(
      children: [
        const SizedBox(height: 20),

        // Instruction
        SubTitleWidget(
          subtitle: 'CLICK OR HOVER TO EXPAND DETAILS',
          color: AppColor.light,
        ),
        const SizedBox(height: 20),

        TitleWidget(
          title: widget.title,
          color: AppColor.accent,
          isLongTitle: true,
        ),
        SizedBox(height: isDesktop ? 40 : 20),

        // Certificates
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 600 : double.infinity,
            ),
            child: SizedBox(
              height: isDesktop ? 500 : null,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  vertical: AppFormat.primaryPadding,
                ),
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 20, height: 20),
                scrollDirection: isDesktop ? Axis.horizontal : Axis.vertical,
                itemCount: widget.certificates.length,
                itemBuilder: (context, index) {
                  final certificate = widget.certificates[index];

                  return AnimatedCertificateCard(
                    certificate: certificate,
                    isExpandedMobile: _expandedIndex == index,
                    onTapMobile: () {
                      setState(() {
                        _expandedIndex = _expandedIndex == index ? null : index;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ),
        if (isDesktop) const Spacer(),

        // Bottom Bar
        BottomBar(scrollController: _scrollController, isDetailView: true),
      ],
    );
  }
}
