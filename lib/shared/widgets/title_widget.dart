import 'package:flutter/material.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: context.textTheme.bodyLarge);
  }
}
