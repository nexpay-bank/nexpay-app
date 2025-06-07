import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hello, Michael John!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          IconButton(onPressed: () {}, icon: Icon(Iconsax.notification_copy)),
        ],
      ),
    );
  }
}
