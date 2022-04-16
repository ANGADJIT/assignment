import 'package:assignment_app/data/models/tasks_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TaskTileWidget extends StatelessWidget {
  const TaskTileWidget({Key? key, required this.task}) : super(key: key);
  final TasksModel task;

  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: ListTile(
      title: task.id.text.bold
          .overflow(TextOverflow.ellipsis)
          .hexColor(Vx.whiteHex)
          .make(),
      subtitle: task.status
          ? HStack([
              'Completed'.toString().text.bold.hexColor(Vx.indigoHex300).make(),
              const Spacer(),
              '${task.dueDate.day}-${task.dueDate.month}-${task.dueDate.year}'
                  .toString()
                  .text
                  .bold
                  .hexColor(Vx.purpleHex300)
                  .make()
            ]).py(context.screenHeight * .02)
          : HStack([
              'Not Completed'
                  .toString()
                  .text
                  .bold
                  .hexColor(Vx.redHex300)
                  .make(),
              const Spacer(),
              '${task.dueDate.day}-${task.dueDate.month}-${task.dueDate.year}'
                  .toString()
                  .text
                  .bold
                  .hexColor(Vx.purpleHex300)
                  .make()
            ]).py(context.screenHeight * .02),
    ))
        .size(context.screenWidth * .9, context.screenHeight * .098)
        .roundedSM
        .hexColor(Vx.grayHex400)
        .shadow
        .border(color: Vx.hexToColor('#d9ed80'))
        .makeCentered()
        .p(context.screenWidth * .02);
  }
}
