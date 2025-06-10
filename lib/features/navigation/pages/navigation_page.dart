import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/card/presentation/pages/card_page.dart';
import 'package:nexpay/features/home/presentation/pages/home_page.dart';
import 'package:nexpay/features/navigation/cubit/navigation_cubit.dart';
import 'package:nexpay/features/profile/presentation/pages/profile_page.dart';
import 'package:nexpay/features/scanner/presentation/pages/scanner_page.dart';
import 'package:nexpay/features/statistic/presentation/pages/statistic_page.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});
  static final List<Widget> _pages = [
    HomePage(),
    StatisticPage(),
    CardPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, index) => Scaffold(
          body: SafeArea(top: false, child: _pages[index]),
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const ScannerPage()),
              );
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.circular(64),
              ),
              child: Icon(Iconsax.scan_copy, size: 32, color: Colors.black),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
            shadowColor: context.colors.onBackground,
            elevation: 0,
            height: 95,
            color: context.colors.surface,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Kiri
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          index == 0 ? Iconsax.home_1 : Iconsax.home_copy,
                          size: 32,
                          color: index == 0
                              ? context.colors.primary
                              : context.colors.onBackground,
                        ),
                        onPressed: () =>
                            context.read<NavigationCubit>().navigate(0),
                      ),
                      Text(
                        'Home',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: index == 0
                              ? context.colors.primary
                              : context.colors.onBackground,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          index == 1
                              ? Iconsax.status_up
                              : Iconsax.status_up_copy,
                          size: 32,
                          color: index == 1
                              ? context.colors.primary
                              : context.colors.onBackground,
                        ),
                        onPressed: () =>
                            context.read<NavigationCubit>().navigate(1),
                      ),
                      Text(
                        'Statistic',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: index == 1
                              ? context.colors.primary
                              : context.colors.onBackground,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          index == 2 ? Iconsax.card : Iconsax.card_copy,
                          size: 32,
                          color: index == 2
                              ? context.colors.primary
                              : context.colors.onBackground,
                        ),
                        onPressed: () =>
                            context.read<NavigationCubit>().navigate(2),
                      ),
                      Text(
                        'Card',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: index == 2
                              ? context.colors.primary
                              : context.colors.onBackground,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          index == 3
                              ? Iconsax.profile_circle
                              : Iconsax.profile_circle_copy,
                          size: 32,
                          color: index == 3
                              ? context.colors.primary
                              : context.colors.onBackground,
                        ),
                        onPressed: () =>
                            context.read<NavigationCubit>().navigate(3),
                      ),
                      Text(
                        'Profile',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: index == 3
                              ? context.colors.primary
                              : context.colors.onBackground,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
