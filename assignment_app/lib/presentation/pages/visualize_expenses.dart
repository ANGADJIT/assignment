import 'package:assignment_app/data/models/expenses_income_model.dart';
import 'package:assignment_app/presentation/widgets/expenses_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class VisualizeExpenses extends StatelessWidget {
  const VisualizeExpenses({Key? key, required this.models}) : super(key: key);
  final List<ExpensesIncomeModel> models;

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
      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpensesTileWidget(model: models[index]);
        },
      ),
    );
  }
}
