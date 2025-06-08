import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexpay/core/constants/colors.dart';
import 'package:nexpay/core/themes/widgets/text_theme.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: TTextTheme.getTextTheme(colors).bodyLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
      ),
    );
  }
}
