import 'package:flutter/material.dart';
import 'package:nexpay/core/constants/colors.dart';

class TElevatedButtonTheme {
  static ElevatedButtonThemeData getTheme(AppColors colors) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: colors.onPrimary,
        backgroundColor: colors.primary,
        shadowColor: colors.background,
        disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.grey,
        side: BorderSide(color: colors.primary),
        padding: const EdgeInsets.symmetric(vertical: 8),
        textStyle: TextStyle(
          fontSize: 16,
          color: colors.background,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
      ),
    );
  }
}
