import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../src/home/widgets/blend_mask.dart';
import '../model/menu_model.dart';
import '../theme/app_color.dart';
import '../theme/app_format.dart';
import '../utils/responsive_widget.dart';
import 'animated_hover_menu_btn.dart';
import 'animated_text_menu_btn.dart';

PreferredSizeWidget buildAppBar({
  required BuildContext context,
  required Size screenSize,
  bool isBlackBackground = true,
}) {
  final double screenWidth = screenSize.width;
  final isDesktop = ResponsiveWidget.isDesktop(context);
  final bool isCompact = screenWidth < 1200;

  final double menuFontSize = (screenWidth * 0.0185).clamp(18.0, 22.0);
  final double itemSpacing = isCompact
      ? (screenWidth * 0.02).clamp(12.0, 22.0)
      : (screenWidth * 0.04).clamp(24.0, 50.0);

  return AppBar(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: const IconThemeData(color: AppColor.background),
    leadingWidth: 220,
    actionsPadding: const EdgeInsets.only(right: AppFormat.primaryPadding),
    leading: Padding(
      padding: const EdgeInsets.only(
        left: AppFormat.primaryPadding,
        top: AppFormat.secondaryPadding,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child:
            AnimatedHoverMenuBtn(
              icon: 'assets/images/tony_logo.webp',
              title: 'Tony\'s Portfolio',
              fontSize: menuFontSize,
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
            ).animate().slide(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
              duration: 500.ms,
              curve: Curves.easeIn,
            ),
      ),
    ),
    actions: isDesktop
        ? [
            // Desktop Menu
            ...desktopMenuItems.map((menu) {
              return Padding(
                padding: const EdgeInsets.only(top: AppFormat.secondaryPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedHoverMenuBtn(
                      title: menu.title,
                      fontSize: menuFontSize,
                      onPressed: () {
                        if (menu.route == '/awards') {
                          context.go('/awards');
                        } else if (menu.route == '/projects') {
                          context.go('/projects');
                        } else if (menu.route == '/experiments') {
                          context.go('/experiments');
                        } else if (menu.route == '/contact') {
                          context.go('/contact');
                        } else {
                          context.go('/');
                        }
                      },
                    ),
                    SizedBox(width: itemSpacing),
                  ],
                ),
              );
            }),

            // Contact Button
            Padding(
              padding: const EdgeInsets.only(top: AppFormat.secondaryPadding),
              child: ElevatedButton(
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
                  padding: EdgeInsets.only(
                    left: isCompact ? 14 : 20,
                    right: 6,
                    top: isCompact ? 10 : 14,
                    bottom: isCompact ? 10 : 14,
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
                        fontSize: menuFontSize,
                      ),
                    ),
                    SizedBox(width: isCompact ? 8 : 10),

                    CircleAvatar(
                      radius: isCompact ? 13 : 16,
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
                        size: isCompact ? 16 : 20,
                      ),
                    ),
                  ],
                ),
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
                      'assets/icons/main_menu.webp',
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
              horizontal: AppFormat.primaryPadding,
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
                      child: Row(
                        children: [
                          // Logo
                          Image.asset(
                            'assets/images/tony_logo.webp',
                            height: 18,
                            width: 18,
                          ),
                          const SizedBox(width: 10),

                          // Web Name
                          Text(
                            'Tony\'s Portfolio',
                            style: TextStyle(
                              fontFamily: 'Questrial',
                              color: AppColor.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
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

                ...mobileMenuItems.map((menu) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedTextMenuBtn(
                        title: menu.title,
                        delay: menu.delay,
                        onPressed: () {
                          if (menu.route == '/awards') {
                            context.go('/awards');
                          } else if (menu.route == '/projects') {
                            context.go('/projects');
                          } else if (menu.route == '/experiments') {
                            context.go('/experiments');
                          } else if (menu.route == '/contact') {
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
