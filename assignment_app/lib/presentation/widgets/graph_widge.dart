import 'package:assignment_app/data/models/expenses_income_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphWidget extends StatelessWidget {
  const GraphWidget({Key? key, required this.tooltipBehavior})
      : super(key: key);
  final TooltipBehavior tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
        tooltipBehavior: tooltipBehavior,
        series: <ChartSeries<ExpensesIncomeModel, String>>[
          DoughnutSeries<ExpensesIncomeModel, String>(
              dataSource: [],
              xValueMapper: (ExpensesIncomeModel data, _) => 'Hello',
              yValueMapper: (ExpensesIncomeModel data, _) => data.income,
              name: 'Gold')
        ]);
  }
}
