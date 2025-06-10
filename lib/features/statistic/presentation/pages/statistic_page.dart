import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/data/models/transaction/transaction.dart';
import 'package:nexpay/features/home/presentation/widgets/recent_transaction_widget.dart';
import 'package:nexpay/features/transfer/presentation/cubit/transfer_cubit.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferCubit, TransferState>(
      builder: (context, state) {
        if (state is TransferSuccess) {
          final income = getDailyAmounts(state.transactions, 'transfer_in');
          final expense = getDailyAmounts(state.transactions, 'transfer_out');
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Stack(
                    children: [
                      const Center(child: TitleWidget(title: 'Statistic')),
                      // const Positioned(right: 0, child: Icon(Iconsax.more_copy)),
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
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 16,
                        //     vertical: 12,
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         "Filter",
                        //         style: Theme.of(context).textTheme.bodyLarge,
                        //       ),
                        //       Container(
                        //         padding: const EdgeInsets.symmetric(
                        //           horizontal: 12,
                        //           vertical: 6,
                        //         ),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(20),
                        //           color: context.colors.surface,
                        //         ),
                        //         child: Row(
                        //           children: const [
                        //             Text("Last 7 Days"),
                        //             SizedBox(width: 4),
                        //             Icon(Icons.keyboard_arrow_down_rounded),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 10),
                        AspectRatio(
                          aspectRatio: 1.6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: BarChart(
                              BarChartData(
                                barGroups: _getBarGroups(income, expense),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 40,
                                      interval: 250,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          '\$${value.toInt()}',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        const days = [
                                          'Mon',
                                          'Tue',
                                          'Wed',
                                          'Thu',
                                          'Fri',
                                          'Sat',
                                          'Sun',
                                        ];
                                        return Text(
                                          days[value.toInt()],
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                gridData: FlGridData(
                                  show: true,
                                  horizontalInterval: 250,
                                ),
                                borderData: FlBorderData(show: false),
                                barTouchData: BarTouchData(enabled: false),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // INCOME & EXPENSE BOX
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              _statCard(
                                Iconsax.arrow_down,
                                "Income",
                                "\$ ${income.fold(0.0, (sum, item) => sum + item).toStringAsFixed(2)}",
                                context,
                              ),
                              const SizedBox(width: 12),
                              _statCard(
                                Iconsax.arrow_up_1,
                                "Expense",
                                "\$ ${expense.fold(0.0, (sum, item) => sum + item).toStringAsFixed(2)}",
                                context,
                                isExpense: true,
                              ),
                            ],
                          ),
                        ),
                        RecentTransactionWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: Text('No Data'));
      },
    );
  }

  List<double> getDailyAmounts(List<Transaction> transactions, String type) {
    final now = DateTime.now();
    List<double> dailyAmounts = List.filled(7, 0);

    for (var trc in transactions) {
      if (trc.type == type) {
        final dayDiff = now.difference(trc.timestamp).inDays;
        if (dayDiff < 7) {
          int index = 6 - dayDiff; // supaya index 0 = Senin
          dailyAmounts[index] += trc.amount;
        }
      }
    }

    return dailyAmounts;
  }

  List<BarChartGroupData> _getBarGroups(
    List<double> income,
    List<double> expense,
  ) {
    return List.generate(7, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: income[i],
            width: 8,
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          BarChartRodData(
            toY: expense[i],
            width: 8,
            color: Color(0xfffce948),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        barsSpace: 4,
      );
    });
  }

  Widget _statCard(
    IconData icon,
    String label,
    String amount,
    BuildContext context, {
    bool isExpense = false,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isExpense
                  ? context.colors.primary.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.1),
              child: Icon(
                icon,
                color: isExpense ? context.colors.primary : Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  amount,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
