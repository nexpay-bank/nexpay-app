import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/home/presentation/widgets/credit_card_widget.dart';
import 'package:nexpay/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:nexpay/features/home/presentation/widgets/quick_send_widget.dart';
import 'package:nexpay/features/home/presentation/widgets/recent_transaction_widget.dart';
import 'package:nexpay/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RefreshController _controller = RefreshController();
  void refresh(BuildContext context) async {
    context.read<TransferCubit>().getTransfer();
    await Future.delayed(const Duration(seconds: 2), () {
      _controller.refreshCompleted();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SmartRefresher(
        controller: _controller,
        enablePullDown: true,
        header: ClassicHeader(
          idleIcon: Icon(
            Iconsax.direct_down_copy,
            color: context.colors.onBackground,
          ),
          releaseIcon: Icon(
            Iconsax.refresh_copy,
            color: context.colors.onBackground,
          ),
        ),
        onRefresh: () async {
          refresh(context);
        },

        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [HomeAppBarWidget(), const CreditCardWidget()],
                    ),
                  ),
                  Container(
                    // height: 500,
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
        ),
      ),
    );
  }
}
