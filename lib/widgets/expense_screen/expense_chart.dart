import 'package:expense_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../models/database_provider.dart';

class ExpenseChart extends StatefulWidget {
  final String category;
  const ExpenseChart(this.category, {super.key});

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var maxY = db.calculateEntriesAndAmount(widget.category)['totalAmount'];
        var list = db.calculateWeekExpenses().reversed.toList();
        return LineChart(
          LineChartData(
            minY: 0,
            maxY: maxY,
            titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  drawBehindEverything: true,
                ),
                leftTitles: AxisTitles(
                  drawBehindEverything: true,
                ),
                rightTitles: AxisTitles(
                  drawBehindEverything: true,
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) => Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6.0, left: 8),
                        child: Text(
                          DateFormat.E().format(list[value.toInt()]['day']),
                        ),
                      ),
                    ),
                  ),
                )),
            lineBarsData: [
              LineChartBarData(
                isStrokeCapRound: true,
                spots: [
                  for (var i = 0; i < list.length; i++)
                    FlSpot(
                      i.toDouble(),
                      list[i]['amount'],
                    ),
                ],
                isCurved: true,
                color: xgreyer,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                    radius: 3,
                    color: xgreyer,
                  ),
                ),
              ),
            ],
            borderData: FlBorderData(
              show: true,
              border: Border(
                bottom: BorderSide(
                  color: xtrans,
                  width: 1,
                ),
                left: BorderSide(
                  color: xtrans,
                  width: 1,
                ),
                right: BorderSide(
                  color: xtrans,
                  width: 0,
                ),
                top: BorderSide(
                  color: xtrans,
                  width: 0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
