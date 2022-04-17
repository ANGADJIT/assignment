import 'package:assignment_app/data/models/expenses_income_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpensesTileWidget extends StatelessWidget {
  const ExpensesTileWidget({Key? key, required this.model}) : super(key: key);
  final ExpensesIncomeModel model;

  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: ListTile(
      leading: Icon(
        Icons.attach_money,
        color: Vx.hexToColor(Vx.greenHex400),
        size: context.screenWidth * .09,
      ),
      title: 'Income : ₹${model.income}'
          .text
          .size(context.screenWidth * .046)
          .bold
          .hexColor(Vx.greenHex400)
          .make(),
      subtitle: 'Expenses : ₹${model.expenses}'
          .text
          .size(context.screenWidth * .034)
          .bold
          .hexColor(Vx.redHex300)
          .make()
          .py(context.screenHeight * .01),
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            const IconData(0xe09b,
                fontFamily: 'MaterialIcons', matchTextDirection: true),
            color: Vx.hexToColor(Vx.indigoHex700),
            size: context.screenWidth * .076,
          )),
    ))
        .size(context.screenWidth * .87, context.screenHeight * .12)
        .rounded
        .hexColor(Vx.grayHex200)
        .border(color: Vx.hexToColor(Vx.blackHex))
        .makeCentered()
        .py(context.screenHeight * .01);
  }
}
