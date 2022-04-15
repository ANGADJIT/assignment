import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VStack([
      'Task App'
          .text
          .headline2(context)
          .bold
          .hexColor(Vx.blackHex)
          .makeCentered()
          .py(context.screenHeight * .02),
      'For awesome task handling 😎'
          .text
          .semiBold
          .headline6(context)
          .hexColor(Vx.blackHex)
          .makeCentered()
          .py(context.screenHeight * .04),
    ]);
  }
}
