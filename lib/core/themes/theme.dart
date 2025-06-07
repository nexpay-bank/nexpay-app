import 'package:flutter/material.dart';
import 'package:nexpay/core/constants/colors.dart';
import 'package:nexpay/core/themes/scheme.dart';
import 'package:nexpay/core/themes/widgets/checkbox_theme.dart';
import 'package:nexpay/core/themes/widgets/elevated_button_theme.dart';
import 'package:nexpay/core/themes/widgets/input_decoration_theme.dart';
import 'package:nexpay/core/themes/widgets/outlined_button_theme.dart';
import 'package:nexpay/core/themes/widgets/text_button_theme.dart';
import 'package:nexpay/core/themes/widgets/text_theme.dart';

final lightColors = LightColors();
final darkColors = DarkColors();

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  extensions: <ThemeExtension<dynamic>>[AppColorScheme(LightColors())],
  elevatedButtonTheme: TElevatedButtonTheme.getTheme(lightColors),
  textTheme: TTextTheme.getTextTheme(lightColors),
  checkboxTheme: TCheckboxTheme.getTheme(lightColors),
  inputDecorationTheme: TInputDecorationTheme.getTheme(lightColors),
  textButtonTheme: TTextButtonTheme.getTheme(lightColors),
  outlinedButtonTheme: TOutlinedButtonTheme.getTheme(lightColors),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  extensions: <ThemeExtension<dynamic>>[AppColorScheme(DarkColors())],
  elevatedButtonTheme: TElevatedButtonTheme.getTheme(darkColors),
  textTheme: TTextTheme.getTextTheme(darkColors),
  checkboxTheme: TCheckboxTheme.getTheme(darkColors),
  inputDecorationTheme: TInputDecorationTheme.getTheme(darkColors),
  textButtonTheme: TTextButtonTheme.getTheme(darkColors),
  outlinedButtonTheme: TOutlinedButtonTheme.getTheme(darkColors),
);
