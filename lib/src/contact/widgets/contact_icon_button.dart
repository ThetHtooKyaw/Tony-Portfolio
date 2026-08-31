import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactIconButton extends StatelessWidget {
  final double screenWidth;
  final String icon;
  final String link;
  const ContactIconButton({
    super.key,
    required this.screenWidth,
    required this.icon,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    final btnSize = (screenWidth * 0.03).clamp(18.0, 24.0);

    return IconButton(
      onPressed: () async {
        final Uri url = Uri.parse(link);

        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          debugPrint('Could not launch $url');
        }
      },
      style: IconButton.styleFrom(
        padding: EdgeInsets.all((screenWidth * 0.03).clamp(18.0, 24.0)),
        backgroundColor: AppColor.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      // padding: const EdgeInsets.all(20),
      icon: Image.asset(
        icon,
        color: AppColor.white,
        height: btnSize,
        width: btnSize,
      ),
    );
  }
}
