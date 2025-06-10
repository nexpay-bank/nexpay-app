import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:isar/isar.dart';
import 'package:nexpay/data/models/auth_token/auth_token.dart';

class HomeAppBarWidget extends StatelessWidget {
  HomeAppBarWidget({super.key});

  final isar = GetIt.I<Isar>();

  Future<AuthToken?> _getUser() async {
    return await isar.authTokens.where().findFirst();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthToken?>(
      future: _getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        final user = snapshot.data;
        final username = user?.username ?? 'User';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hello, $username',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.notification_copy),
              ),
            ],
          ),
        );
      },
    );
  }
}
