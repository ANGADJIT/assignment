import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class VisualizeExpenses extends StatelessWidget {
  const VisualizeExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VxAppBar(
        elevation: .0,
        backgroundColor: Vx.hexToColor('#d9ed80'),
        title: 'Visualize Expenses'
            .text
            .size(context.screenWidth * .08)
            .bold
            .hexColor(Vx.whiteHex)
            .make(),
      ),
    );
  }
}
