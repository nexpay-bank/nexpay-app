import 'package:flutter/material.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';

class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> transactions = [
      {"name": "Transfer to Sam", "type": "transfer", "amount": "90"},
      {"name": "Received from Roger", "type": "received", "amount": "220"},
      {"name": "Transfer to Hinata", "type": "transfer", "amount": "150"},
      {"name": "Received from Samuel", "type": "received", "amount": "950"},
      {"name": "Received from Kai", "type": "received", "amount": "510"},
      {"name": "Transfer to Kiana", "type": "transfer", "amount": "1150"},
    ];
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
            children: transactions.map((transaction) {
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
                          angle: transaction['type'] == "transfer"
                              ? 3.14 / 4 * 3
                              : -3.14 / 4,
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transaction["name"] ?? ""),
                          Text(
                            '17 / 02 / 2025 • 10:32',
                            style: context.textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),

                  Text(
                    "${transaction['type'] == 'transfer' ? '-' : '+'} \$${transaction['amount']}",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: transaction['type'] == 'transfer'
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
}
