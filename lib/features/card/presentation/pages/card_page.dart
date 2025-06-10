import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/card/presentation/cubit/card_cubit.dart';
import 'package:nexpay/features/card/presentation/widgets/card_widget.dart';
import 'package:nexpay/features/card/presentation/widgets/limit_widget.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final RefreshController _controller = RefreshController();
  final PageController controller = PageController();
  void refresh(BuildContext context) async {
    context.read<CardCubit>().getCard();
    await Future.delayed(const Duration(seconds: 2), () {
      _controller.refreshCompleted();
    });
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

        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Stack(
                children: [
                  Center(child: TitleWidget(title: 'Platinum Card')),
                  // Positioned(right: 0, child: Icon(Iconsax.setting_2_copy)),
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
                child: Column(
                  spacing: 16,
                  children: [
                    SizedBox(height: 0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
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
                              onPressed: () {
                                context.read<CardCubit>().createCard();
                              },
                              child: Row(
                                spacing: 8,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.add_copy),
                                  Text("Add Card"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CardCubit, CardState>(
                      builder: (context, state) {
                        return state is CardSuccess
                            ? AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Expanded(
                                  child: PageView(
                                    controller: controller,
                                    children: state.cards
                                        .map(
                                          (card) => CardWidget(
                                            balance: card.balance,
                                            cardHolder: state.holder,
                                            id: card.accountId,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              )
                            : state is CardLoading
                            ? AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: context.colors.onBackground
                                        .withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Shimmer(child: Container()),
                                ),
                              )
                            : Container();
                      },
                    ),
                    BlocBuilder<CardCubit, CardState>(
                      builder: (context, state) {
                        return state is CardSuccess
                            ? SmoothPageIndicator(
                                controller: controller,
                                count: state.cards.length,
                                effect: ExpandingDotsEffect(
                                  activeDotColor: context.colors.primary,
                                  dotHeight: 5,
                                  dotWidth: 70,
                                ),
                              )
                            : Container();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LimitWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
