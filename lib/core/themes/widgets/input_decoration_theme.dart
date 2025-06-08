// lib/core/themes/input_decoration_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexpay/core/constants/colors.dart';

class TInputDecorationTheme {
  static InputDecorationTheme getTheme(AppColors colors) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colors.onBackground.withValues(alpha: 0.1),
      hintStyle: GoogleFonts.manrope(color: colors.onBackground, fontSize: 14),
      labelStyle: GoogleFonts.manrope(
        color: colors.onSurface,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: BorderSide(color: colors.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: BorderSide(
          color: colors.onBackground.withValues(alpha: 0.1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: BorderSide(color: colors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: BorderSide(color: colors.error, width: 2),
      ),
    );
  }
}
