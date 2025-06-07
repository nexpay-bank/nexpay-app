import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/card/presentation/widgets/card_widget.dart';
import 'package:nexpay/features/card/presentation/widgets/limit_widget.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.all(16),
          child: Stack(
            children: [
              Center(child: TitleWidget(title: 'Platinum Card')),
              Positioned(right: 0, child: Icon(Iconsax.setting_2_copy)),
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: context.colors.onBackground.withValues(alpha: 0.3),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Detail Card"),
                        ),
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text("Detail Card"),
                        ),
                      ),
                    ],
                  ),
                  CardWidget(),
                  LimitWidget(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
