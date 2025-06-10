import 'package:flutter/material.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.cardHolder,
    required this.balance,
    required this.id,
  });
  final String cardHolder;
  final double balance;
  final int id;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: context.colors.onBackground,
        ),
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(0.4),
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nexpay',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colors.background,
                        ),
                      ),
                      Image.asset('assets/images/mc.png', width: 42),
                    ],
                  ),
                  Text(
                    '$id',
                    // '•••• •••• •••• $id',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.colors.background,
                    ),
                  ),
                  Text(
                    '\$$balance',
                    style: context.textTheme.displayMedium!.copyWith(
                      color: context.colors.background,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Card holder name',
                            style: context.textTheme.labelSmall!.copyWith(
                              color: context.colors.background,
                            ),
                          ),
                          Text(
                            cardHolder,
                            style: context.textTheme.bodyLarge!.copyWith(
                              color: context.colors.background,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expirary date',
                            style: context.textTheme.labelSmall!.copyWith(
                              color: context.colors.background,
                            ),
                          ),
                          Text(
                            '00/00',
                            style: context.textTheme.bodyLarge!.copyWith(
                              color: context.colors.background,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
