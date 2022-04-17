import 'dart:math';
import 'package:assignment_app/data/models/expenses_income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class VisualizeExpenses extends StatelessWidget {
  const VisualizeExpenses({Key? key, required this.models}) : super(key: key);
  final List<ExpensesIncomeModel> models;

  Color getColor() {
    final colors = [
      Vx.hexToColor(Vx.pinkHex300),
      Vx.hexToColor(Vx.pinkHex400),
      Vx.hexToColor(Vx.pinkHex500),
      Vx.hexToColor(Vx.pinkHex600),
      Vx.hexToColor(Vx.indigoHex200),
      Vx.hexToColor(Vx.indigoHex300),
      Vx.hexToColor(Vx.indigoHex400),
      Vx.hexToColor(Vx.indigoHex500),
      Vx.hexToColor(Vx.purpleHex200),
      Vx.hexToColor(Vx.purpleHex400),
      Vx.hexToColor(Vx.purpleHex500),
      Vx.hexToColor(Vx.purpleHex300),
      Vx.hexToColor(Vx.blueGrayHex300),
    ];

    return colors[Random().nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VxAppBar(
        elevation: .0,
        backgroundColor: Vx.hexToColor('#d9ed80'),
        title: 'Visualize Expenses'
            .text
            .size(context.screenWidth * .06)
            .bold
            .hexColor(Vx.whiteHex)
            .make(),
      ),
      //
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                (context.screenWidth * .07).widthBox,
                VStack([
                  (context.screenHeight * .04).heightBox,
                  'Expenses Graph'
                      .text
                      .size(context.screenWidth * .06)
                      .bold
                      .color(getColor())
                      .makeCentered()
                      .px(context.screenWidth * .02)
                      .box
                      .rounded
                      .shadow2xl
                      .hexColor(Vx.whiteHex)
                      .size(
                          context.screenWidth * .85, context.screenHeight * .05)
                      .makeCentered(),
                  (context.screenHeight * .04).heightBox,
                  PieChart(PieChartData(
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 7.0,
                          startDegreeOffset: 0.0,
                          sections: List.generate(models.length, (index) {
                            return PieChartSectionData(
                                titleStyle: TextStyle(
                                    fontSize: context.screenWidth * .03,
                                    fontWeight: FontWeight.bold,
                                    color: Vx.hexToColor(Vx.whiteHex)),
                                color: getColor(),
                                value: models[index].expenses.toDouble(),
                                title:
                                    '${(models[index].expenses / models.sum((p0) => p0.expenses) * 100).toInt()}%');
                          })))
                      .px(context.screenWidth * .02)
                      .box
                      .rounded
                      .shadow2xl
                      .hexColor(Vx.whiteHex)
                      .size(
                          context.screenWidth * .85, context.screenHeight * .5)
                      .makeCentered(),
                ]),
                (context.screenWidth * .07).widthBox,
                VStack([
                  (context.screenHeight * .04).heightBox,
                  'Income Graphs'
                      .text
                      .size(context.screenWidth * .06)
                      .bold
                      .color(getColor())
                      .makeCentered()
                      .px(context.screenWidth * .02)
                      .box
                      .rounded
                      .shadow2xl
                      .hexColor(Vx.whiteHex)
                      .size(
                          context.screenWidth * .85, context.screenHeight * .05)
                      .makeCentered(),
                  (context.screenHeight * .04).heightBox,
                  PieChart(PieChartData(
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 7.0,
                          startDegreeOffset: 0.0,
                          sections: List.generate(models.length, (index) {
                            return PieChartSectionData(
                                titleStyle: TextStyle(
                                    fontSize: context.screenWidth * .03,
                                    fontWeight: FontWeight.bold,
                                    color: Vx.hexToColor(Vx.whiteHex)),
                                color: getColor(),
                                value: models[index].income.toDouble(),
                                title:
                                    '${(models[index].income / models.sum((p0) => p0.income) * 100).toInt()}%');
                          })))
                      .px(context.screenWidth * .02)
                      .box
                      .rounded
                      .shadow2xl
                      .hexColor(Vx.whiteHex)
                      .size(
                          context.screenWidth * .85, context.screenHeight * .5)
                      .makeCentered(),
                ]),
                (context.screenWidth * .07).widthBox,
              ],
            ),
          )
        ],
      )),
    );
  }
}
