import 'package:flutter/material.dart';

abstract class AppColors {
  Color get primary;
  Color get onPrimary;
  Color get secondary;
  Color get onSecondary;
  Color get background;
  Color get onBackground;
  Color get surface;
  Color get onSurface;
  Color get error;
  Color get onError;
}

class LightColors implements AppColors {
  @override
  Color get primary => const Color(0xFFFCE948);
  @override
  Color get onPrimary => Colors.white;
  @override
  Color get secondary => const Color(0xFF03DAC6);
  @override
  Color get onSecondary => Colors.black;
  @override
  Color get background => const Color(0xFFF6F6F6);
  @override
  Color get onBackground => Colors.black87;
  @override
  Color get surface => Colors.white;
  @override
  Color get onSurface => Colors.black87;
  @override
  Color get error => const Color(0xFFB00020);
  @override
  Color get onError => Colors.white;
}

class DarkColors implements AppColors {
  @override
  Color get primary => const Color(0xFFFCE948);
  @override
  Color get onPrimary => Colors.black;
  @override
  Color get secondary => const Color(0xFF03DAC6);
  @override
  Color get onSecondary => Colors.white;
  @override
  Color get background => const Color(0xFF131313);
  @override
  Color get onBackground => Colors.white;
  @override
  Color get surface => const Color(0xFF202020);
  @override
  Color get onSurface => Colors.white70;
  @override
  Color get error => const Color(0xFFCF6679);
  @override
  Color get onError => Colors.black;
}
