import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';

class NotFoundView extends StatelessWidget {
  final String routeName;
  const NotFoundView({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final parsedRoute = routeName.substring(1);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/animations/404.json",
              repeat: true,
              height: screenSize.height * 0.6,
              width: screenSize.width * 0.8,
            ),

            AutoSizeText(
              "$parsedRoute Page not found!",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              maxFontSize: 20.0,
              minFontSize: 16.0,
              style: TextStyle(
                fontFamily: 'Open Sans',
                color: AppColor.white,
                fontSize: screenSize.width * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
