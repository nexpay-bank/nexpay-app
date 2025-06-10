import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';

class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(
      builder: (context, state) {
        if (state is TransferLoading) {
          return Column(
            children: [SizedBox(height: 50), CircularProgressIndicator()],
          );
        }
        if (state is TransferSuccess) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleWidget(title: 'Recent Transaction'),
                    TextButton(onPressed: () {}, child: Text('View All')),
                  ],
                ),
                Column(
                  spacing: 16,
                  children: state.transactions.map((transaction) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 9,
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90),
                                color: context.colors.onBackground.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                              child: Transform.rotate(
                                angle: transaction.type == "transfer_out"
                                    ? 3.14 / 4 * 3
                                    : -3.14 / 4,
                                child: Icon(Icons.arrow_back),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(transaction.type.split("_").join(" ")),
                                Text(
                                  DateFormat(
                                    'dd / MM / yyyy • HH:mm',
                                  ).format(transaction.timestamp),
                                  style: context.textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ],
                        ),

                        Text(
                          "${transaction.type == 'transfer_out' ? '-' : '+'} \$${transaction.amount}",
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: transaction.type == 'transfer_out'
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }
        return SizedBox(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Text('No transaction data'),
          ),
        );
      },
    );
  }
}
