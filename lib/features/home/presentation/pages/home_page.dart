import 'package:flutter/material.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/home/presentation/widgets/credit_card_widget.dart';
import 'package:nexpay/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:nexpay/features/home/presentation/widgets/quick_send_widget.dart';
import 'package:nexpay/features/home/presentation/widgets/recent_transaction_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Image.asset(
            'assets/images/grid_pattern.png',
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const HomeAppBarWidget(),
                    const CreditCardWidget(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: context.colors.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: const Column(
                  children: [QuickSendWidget(), RecentTransactionWidget()],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
