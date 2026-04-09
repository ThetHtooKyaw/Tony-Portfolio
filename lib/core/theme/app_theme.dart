import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final base = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColor.background,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return base.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 40),
          foregroundColor: AppColor.white,
          backgroundColor: AppColor.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppFormat.primaryBorderRadius),
          ),
          // textStyle: AppTextStyle.titleSmall,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(100, 40),
          foregroundColor: AppColor.white,
          // side: const BorderSide(color: AppColor.primary, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppFormat.primaryBorderRadius),
          ),
          // textStyle: AppTextStyle.bodyLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.white,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          splashFactory: NoSplash.splashFactory,
          // textStyle: AppTextStyle.bodyLarge,
        ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColor.white,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppFormat.secondaryBorderRadius,
            ),
          ),
        ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
      ),
    );
  }
}
