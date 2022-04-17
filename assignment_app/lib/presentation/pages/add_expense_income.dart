import 'package:assignment_app/data/models/expenses_income_model.dart';
import 'package:assignment_app/logic/database/expenses_income_db.dart';
import 'package:assignment_app/presentation/widgets/button_widget.dart';
import 'package:assignment_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class AddIncomeExpenses extends StatelessWidget {
  AddIncomeExpenses({Key? key}) : super(key: key);
  final TextEditingController _income = TextEditingController();
  final TextEditingController _expenses = TextEditingController();

  final ExpensesIncomeDb _expensesIncomeDb = ExpensesIncomeDb();

  Future<void> add(BuildContext context) async {
    final result = await checkForInternet();

    if (result) {
      if (_expenses.text.isEmpty || _income.text.isEmpty) {
        showSnackbar(
            context: context,
            message: 'error : fields required..',
            isError: true);
      } else {
        final _model = ExpensesIncomeModel(
            expenses: int.parse(_expenses.text),
            income: int.parse(_income.text));

        await loading('Saving...');
        await _expensesIncomeDb.add(_model);
        await loading('', show: false);

        //
        showSnackbar(context: context, message: 'Saved successfully..');
        context.pop();
      }
    } else {
      showSnackbar(
          context: context, message: 'error: no internet', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VxAppBar(
        elevation: .0,
        backgroundColor: Vx.hexToColor('#d9ed80'),
        title: 'Add Expenses 💲'
            .text
            .size(context.screenWidth * .08)
            .bold
            .overflow(TextOverflow.ellipsis)
            .hexColor(Vx.whiteHex)
            .make(),
      ),
      body: ListView(
        children: [
          (context.screenWidth * .04).heightBox,
          VxTextField(
            borderColor: Vx.hexToColor(Vx.grayHex300),
            clear: false,
            hint: 'Enter Income In Rs',
            controller: _income,
            maxLength: 6,
            autofocus: true,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.phone,
            height: context.screenHeight * .07,
            fillColor: Vx.hexToColor(Vx.whiteHex),
            borderType: VxTextFieldBorderType.roundLine,
          ).px(context.screenWidth * .06),
          (context.screenWidth * .04).heightBox,
          VxTextField(
            borderColor: Vx.hexToColor(Vx.grayHex300),
            clear: false,
            hint: 'Enter Expenses In Rs',
            maxLength: 6,
            controller: _expenses,
            autofocus: true,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.phone,
            height: context.screenHeight * .07,
            fillColor: Vx.hexToColor(Vx.whiteHex),
            borderType: VxTextFieldBorderType.roundLine,
          ).px(context.screenWidth * .06),
          ButtonWidget(
              buttonText: 'Save',
              buttonColor: Vx.hexToColor('#d9ed80'),
              onPressed: () => add(context))
        ],
      ),
    );
  }
}
