import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexpay/core/constants/colors.dart';

class TTextTheme {
  static TextTheme getTextTheme(AppColors colors) {
    return TextTheme(
      displayLarge: GoogleFonts.manrope(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: colors.onBackground,
      ),
      displayMedium: GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: colors.onBackground,
      ),
      titleLarge: GoogleFonts.manrope(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colors.onBackground,
      ),
      bodySmall: GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.onBackground,
      ),
      bodyMedium: GoogleFonts.manrope(fontSize: 16, color: colors.onBackground),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 20,
        color: colors.onBackground,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.onBackground,
      ),
      labelSmall: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.onBackground.withValues(alpha: 0.7),
      ),
    );
  }
}
