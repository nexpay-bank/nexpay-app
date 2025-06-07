import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Iconsax.home_copy), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.status_up_copy),
          label: 'Statistic',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.user_copy),
          label: 'Profile',
        ),
      ],
    );
  }
}
