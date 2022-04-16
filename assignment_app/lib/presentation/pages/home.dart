import 'package:assignment_app/data/models/tasks_model.dart';
import 'package:assignment_app/logic/database/task_db.dart';
import 'package:assignment_app/presentation/pages/add_task.dart';
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
          ]).px(context.screenWidth * .02)
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
          VxBox(
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
              .px(context.screenWidth * .02)
        ]))
            .size(context.screenWidth * .9, context.screenHeight * .17)
            .roundedSM
            .hexColor(Vx.grayHex100)
            .shadow2xl
            .border(color: Vx.hexToColor('#d9ed80'))
            .makeCentered()
      ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Vx.hexToColor('#d9ed80'),
        onPressed: () async {
          await TasksDb().getData();
          // context.nextPage(const AddTask());
        },
        child: Icon(
          Icons.task,
          color: Vx.hexToColor(Vx.whiteHex),
        ),
      ).px(context.screenWidth * .02),
    );
  }
}
