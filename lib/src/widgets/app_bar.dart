import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tony_portfolio/core/data/menu_list.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/widgets/animated_hover_menu_btn.dart';
import 'package:tony_portfolio/src/widgets/animated_text_menu_btn.dart';
import 'package:tony_portfolio/src/home/widgets/blend_mask.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';

PreferredSizeWidget buildAppBar({
  required BuildContext context,
  required Size screenSize,
  bool isBlackBackground = true,
}) {
  final isDesktop = ResponsiveWidget.isDesktop(context);
  final isTablet = ResponsiveWidget.isTablet(context);

  return AppBar(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: const IconThemeData(color: AppColor.background),
    leadingWidth: 220,
    actionsPadding: const EdgeInsets.only(right: AppFormat.priamaryPadding),
    // Project Label
    leading: Padding(
      padding: const EdgeInsets.only(
        left: AppFormat.priamaryPadding,
        top: AppFormat.secondaryPadding,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child:
            AnimatedHoverMenuBtn(
              title: '© Tony\'s Portfolio',
              fontSize: (screenSize.width * 0.025).clamp(18, 22),
              onPressed: () => context.go('/'),
            ).animate().slide(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
              duration: 500.ms,
              curve: Curves.easeIn,
            ),
      ),
    ),
    actions: isDesktop || isTablet
        ? [
            // Desktop Menu
            ...desktopMenuList.map((menu) {
              return Padding(
                padding: const EdgeInsets.only(top: AppFormat.secondaryPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedHoverMenuBtn(
                      title: menu['title'],
                      fontSize: (screenSize.width * 0.025).clamp(18, 22),
                      onPressed: () {
                        if (menu['route'] == '/awards') {
                          context.go('/awards');
                        } else if (menu['route'] == '/about') {
                          context.go('/about');
                        } else {
                          context.go('/');
                        }
                      },
                    ),
                    SizedBox(width: (screenSize.width * 0.04).clamp(16, 50)),
                  ],
                ),
              );
            }),

            // Contact Button
            ElevatedButton(
              onPressed: () => context.go('/contact'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isBlackBackground
                    ? AppColor.white
                    : AppColor.background,
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
                  AutoSizeText(
                    'Get in touch',
                    maxFontSize: 22,
                    minFontSize: 16,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: isBlackBackground
                          ? AppColor.background
                          : AppColor.white,
                      fontSize: screenSize.width * 0.025,
                    ),
                  ),
                  const SizedBox(width: 10),

                  CircleAvatar(
                    radius: 16,
                    backgroundColor: isBlackBackground
                        ? AppColor.background
                        : AppColor.white,
                    foregroundColor: isBlackBackground
                        ? AppColor.white
                        : AppColor.background,
                    child: Icon(
                      Icons.arrow_forward,
                      // color: isBlackBackground
                      //     ? AppColor.white
                      //     : AppColor.background,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ].animate().slide(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
            duration: 500.ms,
            curve: Curves.easeIn,
          )
        : [
            // Mobile Menu Button
            RepaintBoundary(
              child: BlendMask(
                blendMode: BlendMode.difference,
                child: Builder(
                  builder: (context) => IconButton(
                    onPressed: () => _showMainMenu(context: context),
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    ),
                    icon: Image.asset(
                      'assets/icons/main_menu.png',
                      color: AppColor.white,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),
            ),
          ].animate().slide(
            begin: const Offset(0.0, -1.4),
            end: Offset.zero,
            duration: 500.ms,
            curve: Curves.easeIn,
          ),
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
                    Expanded(
                      child: Text(
                        '© Tony\'s Portfolio',
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

                ...mobileMenuList.map((menu) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedTextMenuBtn(
                        title: menu['title'],
                        delay: menu['delay'],
                        onPressed: () {
                          if (menu['route'] == '/awards') {
                            context.go('/awards');
                          } else if (menu['route'] == '/about') {
                            context.go('/about');
                          } else if (menu['route'] == '/contact') {
                            context.go('/contact');
                          } else {
                            context.go('/');
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      );
    },
  );
}
