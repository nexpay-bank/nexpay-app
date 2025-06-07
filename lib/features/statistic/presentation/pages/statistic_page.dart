import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/home/presentation/widgets/recent_transaction_widget.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                const Center(child: TitleWidget(title: 'Statistic')),
                const Positioned(right: 0, child: Icon(Iconsax.more_copy)),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Filter",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: context.colors.surface,
                          ),
                          child: Row(
                            children: const [
                              Text("Last 7 Days"),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // GRAFIK BATANG
                  AspectRatio(
                    aspectRatio: 1.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BarChart(
                        BarChartData(
                          barGroups: _getBarGroups(),
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
                          "\$5,769",
                          context,
                        ),
                        const SizedBox(width: 12),
                        _statCard(
                          Iconsax.arrow_up_1,
                          "Expense",
                          "\$1,986",
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

  List<BarChartGroupData> _getBarGroups() {
    final List<double> income = [400, 200, 100, 250, 600, 500, 150];
    final List<double> expense = [600, 800, 700, 300, 900, 850, 400];

    return List.generate(7, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: expense[i],
            width: 8,
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          BarChartRodData(
            toY: income[i],
            width: 8,
            color: Colors.yellow,
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
