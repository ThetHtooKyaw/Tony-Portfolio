import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/home/widgets/animated_hover_menu_btn.dart';
import 'package:tony_portfolio/src/home/widgets/animated_text_menu_btn.dart';

PreferredSizeWidget buildAppBar({
  required Size screenSize,
  required bool isDesktop,
}) {
  final double menuSpacing = (screenSize.width * 0.04).clamp(20, 50);

  return AppBar(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: const IconThemeData(color: AppColor.background),
    leadingWidth: 220,
    actionsPadding: const EdgeInsets.only(right: AppFormat.priamaryPadding),
    leading: Padding(
      padding: const EdgeInsets.only(left: AppFormat.priamaryPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedHoverMenuBtn(title: 'Tony\'s Portfolio'),
      ),
    ),
    actions: isDesktop
        ? [
            AnimatedHoverMenuBtn(title: 'Home', onPressed: () {}),
            SizedBox(width: menuSpacing),

            AnimatedHoverMenuBtn(title: 'About', onPressed: () {}),
            SizedBox(width: menuSpacing),

            AnimatedHoverMenuBtn(title: 'Awards', onPressed: () {}),
            SizedBox(width: menuSpacing),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppFormat.circleBorderRadius,
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 6,
                  top: 14,
                  bottom: 14,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Get in touch',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: AppColor.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColor.white,
                    child: Icon(Icons.arrow_forward, size: 20),
                  ),
                ],
              ),
            ),
          ]
        : [
            Builder(
              builder: (context) => IconButton(
                onPressed: () => _showMainMenu(context: context),
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                ),
                icon: Image.asset(
                  'assets/icons/main_menu.png',
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ],
  );
}

void _showMainMenu({required BuildContext context}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
            .animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
            ),
        child: child,
      );
    },
    pageBuilder: (buildContext, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: AppFormat.secondaryPadding,
              horizontal: AppFormat.priamaryPadding,
            ),
            width: double.infinity,
            color: AppColor.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tony\'s Portfolio',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          color: AppColor.white,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(padding: EdgeInsets.zero),
                      icon: Icon(Icons.close, size: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                AnimatedTextMenuBtn(
                  title: 'Home',
                  delay: Duration(milliseconds: 150),
                  onPressed: () {},
                ),
                const SizedBox(height: 16),

                AnimatedTextMenuBtn(
                  title: 'About',
                  delay: Duration(milliseconds: 250),
                  onPressed: () {},
                ),
                const SizedBox(height: 16),

                AnimatedTextMenuBtn(
                  title: 'Awards',
                  delay: Duration(milliseconds: 350),
                  onPressed: () {},
                ),
                const SizedBox(height: 16),

                AnimatedTextMenuBtn(
                  title: 'Get in touch',
                  delay: Duration(milliseconds: 450),
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    },
  );
}
