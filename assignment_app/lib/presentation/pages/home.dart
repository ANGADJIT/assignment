import 'package:assignment_app/logic/database/expenses_income_db.dart';
import 'package:assignment_app/presentation/pages/add_expense_income.dart';
import 'package:assignment_app/presentation/pages/add_task.dart';
import 'package:assignment_app/presentation/pages/view_tasks.dart';
import 'package:assignment_app/presentation/pages/visualize_expenses.dart';
import 'package:assignment_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.userName}) : super(key: key);
  final String userName;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ExpensesIncomeDb _expensesIncomeDb = ExpensesIncomeDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.hexToColor(Vx.whiteHex),
      appBar: VxAppBar(
        actions: [
          VStack([
            'Welcome'
                .text
                .size(context.screenWidth * .04)
                .bold
                .hexColor(Vx.whiteHex)
                .make(),
            widget.userName.text.capitalize
                .size(context.screenWidth * .04)
                .bold
                .hexColor(Vx.whiteHex)
                .make()
          ]).px(context.screenWidth * .03)
        ],
        elevation: .0,
        backgroundColor: Vx.hexToColor('#d9ed80'),
        title: 'Task App'
            .text
            .size(context.screenWidth * .08)
            .bold
            .hexColor(Vx.whiteHex)
            .make(),
      ),
      body: SafeArea(
          child: VStack([
        (context.screenHeight * .02).heightBox,
        VxBox(
                child: VStack([
          'View All Task'
              .text
              .headline4(context)
              .bold
              .hexColor(Vx.grayHex300)
              .make(),
          (context.screenHeight * .04).heightBox,
          MaterialButton(
            onPressed: () => context.nextPage(const ViewTasks()),
            child: VxBox(
                    child: 'view -> -> '
                        .text
                        .bold
                        .hexColor(Vx.whiteHex)
                        .makeCentered())
                .size(context.screenWidth * .3, context.screenHeight * .04)
                .roundedLg
                .hexColor('#d9ed80')
                .shadow2xl
                .make()
                .px(context.screenWidth * .02),
          )
        ]))
            .size(context.screenWidth * .9, context.screenHeight * .17)
            .roundedSM
            .hexColor(Vx.grayHex100)
            .shadow2xl
            .border(color: Vx.hexToColor('#d9ed80'))
            .makeCentered(),
        (context.screenHeight * .02).heightBox,
        VxBox(
                child: VStack([
          'Visualize Expenses'
              .text
              .headline4(context)
              .bold
              .hexColor(Vx.grayHex300)
              .make(),
          (context.screenHeight * .04).heightBox,
          MaterialButton(
            onPressed: () async {
              await loading('Getting data...');
              final models = await _expensesIncomeDb.getExpenses();
              await loading('', show: false);

              context.nextPage(VisualizeExpenses(models: models));
            },
            child: VxBox(
                    child: 'view -> -> '
                        .text
                        .bold
                        .hexColor(Vx.whiteHex)
                        .makeCentered())
                .size(context.screenWidth * .3, context.screenHeight * .04)
                .roundedLg
                .hexColor('#d9ed80')
                .shadow2xl
                .make()
                .px(context.screenWidth * .02),
          )
        ]))
            .size(context.screenWidth * .9, context.screenHeight * .17)
            .roundedSM
            .hexColor(Vx.grayHex100)
            .shadow2xl
            .border(color: Vx.hexToColor('#d9ed80'))
            .makeCentered(),
        (context.screenHeight * .02).heightBox,
        VxBox(
                child: VStack([
          'Expenses Insight'
              .text
              .headline4(context)
              .bold
              .hexColor(Vx.grayHex300)
              .make(),
          (context.screenHeight * .04).heightBox,
          MaterialButton(
            onPressed: () {},
            child: VxBox(
                    child: 'view -> -> '
                        .text
                        .bold
                        .hexColor(Vx.whiteHex)
                        .makeCentered())
                .size(context.screenWidth * .3, context.screenHeight * .04)
                .roundedLg
                .hexColor('#d9ed80')
                .shadow2xl
                .make()
                .px(context.screenWidth * .02),
          )
        ]))
            .size(context.screenWidth * .9, context.screenHeight * .17)
            .roundedSM
            .hexColor(Vx.grayHex100)
            .shadow2xl
            .border(color: Vx.hexToColor('#d9ed80'))
            .makeCentered(),
      ])),
      floatingActionButton: HStack([
        FloatingActionButton(
          heroTag: 'btn1',
          backgroundColor: Vx.hexToColor('#d9ed80'),
          onPressed: () {
            context.nextPage(const AddTask());
          },
          child: Icon(
            Icons.task,
            color: Vx.hexToColor(Vx.whiteHex),
          ),
        ).px(context.screenWidth * .02),
        FloatingActionButton(
          heroTag: 'btn2',
          backgroundColor: Vx.hexToColor(Vx.indigoHex300),
          onPressed: () {
            context.nextPage(AddIncomeExpenses());
          },
          child: Icon(
            Icons.attach_money,
            color: Vx.hexToColor(Vx.whiteHex),
          ),
        ).px(context.screenWidth * .02)
      ]),
    );
  }
}
