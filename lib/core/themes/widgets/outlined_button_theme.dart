import 'package:flutter/material.dart';
import 'package:nexpay/core/constants/colors.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 8),
        textStyle: TextStyle(
          fontSize: 16,
          color: colors.onBackground,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
      ),
    );
  }
}
