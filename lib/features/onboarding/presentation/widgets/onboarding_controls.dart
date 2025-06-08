import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/routes/route_name.dart';

class OnboardingControls extends StatelessWidget {
  final PageController controller;
  final int currentIndex;

  const OnboardingControls({
    super.key,
    required this.controller,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isLast = currentIndex == 2;

    return Positioned(
      bottom: 40,
      left: 24,
      right: 24,
      child: Row(
        spacing: 16,
        children: [
          // Expanded(
          //   child: OutlinedButton(
          //     onPressed: () {
          //       if (currentIndex == 0) {
          //         // Navigator.pushReplacementNamed(context, '/auth');
          //       } else {
          //         controller.previousPage(
          //           duration: const Duration(milliseconds: 400),
          //           curve: Curves.easeInOut,
          //         );
          //       }
          //     },
          //     child: Row(
          //       spacing: 8,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Transform.rotate(
          //           angle: -3.14,
          //           child: Icon(Iconsax.arrow_right_1_copy),
          //         ),
          //         Text('Back'),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (isLast) {
                  Navigator.pushReplacementNamed(context, RouteName.login);
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isLast ? 'Get Started' : 'Next'),
                  Icon(Iconsax.arrow_right_1_copy),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
