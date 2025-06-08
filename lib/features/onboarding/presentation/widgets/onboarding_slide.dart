import 'package:flutter/material.dart';

class OnboardingSlide extends StatelessWidget {
  final String imageAsset;

  const OnboardingSlide({super.key, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Biar lebih dramatis kayak di desainmu~
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        imageAsset,
        fit: BoxFit.cover, // Biar gambarnya full-screen kayak yang kamu mau
      ),
    );
  }
}
