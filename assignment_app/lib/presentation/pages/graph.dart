import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VxAppBar(
        elevation: .0,
        backgroundColor: Vx.hexToColor('#d9ed80'),
        title: 'Doughnut Chart'
            .text
            .size(context.screenWidth * .06)
            .bold
            .hexColor(Vx.whiteHex)
            .make(),
      ),
      //
      body: SafeArea(
          child: Stack(
        children: [VxBox().make()],
      )),
    );
  }
}
