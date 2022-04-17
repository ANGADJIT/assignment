import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Insights extends StatelessWidget {
  const Insights(
      {Key? key,
      required this.values,
      required this.text,
      required this.amount,
      required this.color})
      : super(key: key);
  final List<double> values;
  final List<Color> color;
  final String text;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VxAppBar(
        elevation: .0,
        backgroundColor: Vx.hexToColor('#d9ed80'),
        title: 'Insights'
            .text
            .size(context.screenWidth * .06)
            .bold
            .hexColor(Vx.whiteHex)
            .make(),
      ),
      //
      body: SafeArea(
          child: ListView(children: [
        (context.screenHeight * .04).heightBox,
        'Insights'
            .text
            .size(context.screenWidth * .06)
            .bold
            .color(color[0])
            .makeCentered()
            .px(context.screenWidth * .02)
            .box
            .rounded
            .shadow2xl
            .hexColor(Vx.whiteHex)
            .size(context.screenWidth * .85, context.screenHeight * .05)
            .makeCentered(),
        (context.screenHeight * .04).heightBox,
        PieChart(PieChartData(
                borderData: FlBorderData(show: false),
                sectionsSpace: 7.0,
                startDegreeOffset: 0.0,
                sections: List.generate(values.length, (index) {
                  return PieChartSectionData(
                      titleStyle: TextStyle(
                          fontSize: context.screenWidth * .03,
                          fontWeight: FontWeight.bold,
                          color: Vx.hexToColor(Vx.whiteHex)),
                      color: color[index],
                      value: values[index],
                      title:
                          '${((values[index] / (values[0] + values[1])) * 100).toInt()}%');
                })))
            .px(context.screenWidth * .02)
            .box
            .rounded
            .shadow2xl
            .hexColor(Vx.whiteHex)
            .size(context.screenWidth * .85, context.screenHeight * .5)
            .makeCentered(),
        (context.screenHeight * .02).heightBox,
        HStack([
          'Income'
              .text
              .size(context.screenWidth * .06)
              .bold
              .color(color[0])
              .makeCentered(),
          const Spacer(),
          'Expenses'
              .text
              .size(context.screenWidth * .06)
              .bold
              .color(color[1])
              .makeCentered(),
        ])
            .px(context.screenWidth * .02)
            .box
            .rounded
            .shadow2xl
            .hexColor(Vx.whiteHex)
            .size(context.screenWidth * .85, context.screenHeight * .05)
            .makeCentered(),
        (context.screenHeight * .02).heightBox,
        VxBox(
                child: VStack([
          (context.screenHeight * .01).heightBox,
          text.text.center
              .size(context.screenWidth * .06)
              .bold
              .color(color[1])
              .makeCentered(),
          (context.screenHeight * .01).heightBox,
          amount
              .toString()
              .text
              .center
              .size(context.screenWidth * .06)
              .bold
              .color(color[0])
              .makeCentered()
        ]))
            .rounded
            .shadow2xl
            .hexColor(Vx.whiteHex)
            .size(context.screenWidth * .85, context.screenHeight * .2)
            .makeCentered(),
        (context.screenHeight * .02).heightBox,
      ])),
    );
  }
}
