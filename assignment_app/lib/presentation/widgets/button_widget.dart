import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key, required this.buttonText, required this.buttonColor,required this.onPressed})
      : super(key: key);
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: VxBox(
        child:  buttonText
              .text
              .headline6(context)
              .semiBold
              .hexColor(Vx.blackHex)
              .makeCentered()
      )
          .size(context.screenWidth * .75, context.screenHeight * .08)
          .color(buttonColor)
          .roundedLg
          .shadow2xl
          .makeCentered(),
    );
  }
}
