import 'package:flutter/material.dart';
import 'package:nexpay/core/constants/colors.dart';
import 'package:nexpay/core/themes/widgets/elevated_button_theme.dart';
import 'package:nexpay/core/themes/widgets/text_theme.dart';
import 'scheme.dart';

extension AppColorExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColorScheme>()!.colors;
}

extension AppTextExtension on BuildContext {
  TextTheme get textTheme => TTextTheme.getTextTheme(colors);
}
