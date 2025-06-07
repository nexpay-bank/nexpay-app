import 'package:flutter/material.dart';
import 'package:nexpay/core/constants/colors.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final AppColors colors;

  const AppColorScheme(this.colors);

  @override
  ThemeExtension<AppColorScheme> copyWith({AppColors? colors}) {
    return AppColorScheme(colors ?? this.colors);
  }

  @override
  ThemeExtension<AppColorScheme> lerp(
    ThemeExtension<AppColorScheme>? other,
    double t,
  ) {
    return this;
  }
}
