import 'package:flutter/material.dart';
import 'package:nexpay/core/constants/colors.dart';
import 'package:nexpay/core/themes/widgets/text_theme.dart';

class TOutlinedButtonTheme {
  static OutlinedButtonThemeData getTheme(AppColors colors) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.primary,
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: colors.primary.withValues(alpha: 0.5),
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: TTextTheme.getTextTheme(colors).bodyLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
      ),
    );
  }
}
