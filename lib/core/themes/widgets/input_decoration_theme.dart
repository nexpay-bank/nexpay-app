// lib/core/themes/input_decoration_theme.dart

import 'package:flutter/material.dart';
import 'package:nexpay/core/constants/colors.dart';

class TInputDecorationTheme {
  static InputDecorationTheme getTheme(AppColors colors) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colors.background,
      hintStyle: TextStyle(
        color: colors.onBackground,
        fontFamily: 'Outfit',
        fontSize: 14,
      ),
      labelStyle: TextStyle(
        color: colors.onSurface,
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: BorderSide(color: colors.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: BorderSide(color: colors.primary),
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
