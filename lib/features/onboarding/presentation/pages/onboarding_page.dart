import 'package:flutter/material.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/onboarding_slide.dart';
import '../widgets/onboarding_controls.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: _onPageChanged,
            children: const [
              OnboardingSlide(imageAsset: 'assets/images/onboarding_1.png'),
              OnboardingSlide(imageAsset: 'assets/images/onboarding_1.png'),
              OnboardingSlide(imageAsset: 'assets/images/onboarding_1.png'),
            ],
          ),
          OnboardingControls(
            controller: _controller,
            currentIndex: _currentIndex,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: context.colors.primary,
                dotHeight: 5,
                dotWidth: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
