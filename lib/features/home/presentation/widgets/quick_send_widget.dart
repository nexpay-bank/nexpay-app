import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:nexpay/features/transfer/presentation/pages/transfer_page.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';

class QuickSendWidget extends StatelessWidget {
  const QuickSendWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  child: TitleWidget(title: "Quick Send"),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => TransferPage(),
                            ),
                          ),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: context.colors.onBackground.withAlpha(20),
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: DottedBorder(
                              options: CircularDottedBorderOptions(
                                dashPattern: [10, 5],
                                strokeWidth: 1,
                                color: context.colors.onBackground,
                                padding: EdgeInsets.all(12),
                              ),
                              child: Center(
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  state is TransferSuccess
                      ? Row(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: state.transactions
                              .map((trc) => trc.relatedAccountId)
                              .toSet()
                              .map(
                                (id) => GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          TransferPage(qrData: id.toString()),
                                    ),
                                  ),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    padding: EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: context.colors.onBackground
                                          .withAlpha(25),
                                      border: Border.all(
                                        width: 1,
                                        color: context.colors.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(128),
                                    ),
                                    child: Center(child: Text(id.toString())),
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
