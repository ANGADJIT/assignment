import 'package:assignment_app/data/models/tasks_model.dart';
import 'package:assignment_app/logic/cubit/tasks_cubit.dart';
import 'package:assignment_app/logic/database/task_db.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/functions.dart';
import '../widgets/button_widget.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({Key? key, required this.task, required this.cubit})
      : super(key: key);
  final TasksModel task;
  final TasksCubit cubit;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late final TextEditingController _taskString;
  DateTime? _time;
  bool _isCompleted = false;

  @override
  void initState() {
    _taskString = TextEditingController(text: widget.task.id);
    _time = widget.task.dueDate;
    _isCompleted = widget.task.status;

    super.initState();
  }

  Future<void> _updateData() async {
    final result = await checkForInternet();

    if (result) {
      if (_time == null || _taskString.text.isEmpty) {
        showSnackbar(
            context: context,
            message: 'error: fields required..',
            isError: true);
      } else {
        // data to be updated
        Map<String, dynamic> taskMap = widget.task.toMap();
        taskMap['id'] = _taskString.text;
        taskMap['status'] = _isCompleted;
        taskMap['dueDate'] = _time.toString();

        //
        Map<String, dynamic> data = {};
        data[widget.task.upperKey] = {widget.task.lowerKey: taskMap};

        await loading('Updating tasks...');
        await TasksDb().updateData(data: data, reference: widget.task.refrence);
        await loading('', show: false);

        showSnackbar(context: context, message: 'Updated.. successfully');
        widget.cubit.init();
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
          title: 'Update Task'
              .text
              .size(context.screenWidth * .08)
              .bold
              .hexColor(Vx.whiteHex)
              .make(),
        ),
        body: ListView(
          children: [
            (context.screenWidth * .04).heightBox,
            VxTextField(
              borderColor: Vx.hexToColor(Vx.grayHex300),
              clear: false,
              controller: _taskString,
              hint: 'Enter task',
              autofocus: true,
              keyboardType: TextInputType.text,
              height: context.screenHeight * .07,
              fillColor: Vx.hexToColor(Vx.whiteHex),
              borderType: VxTextFieldBorderType.roundLine,
            ).px(context.screenWidth * .06),
            (context.screenWidth * .04).heightBox,
            ButtonWidget(
                buttonText: 'Select due date',
                buttonColor: Vx.hexToColor(Vx.whiteHex),
                onPressed: () async {
                  _time = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(90.days));

                  VxToast.show(context,
                      msg: '${_time!.day}-${_time!.month}-${_time!.year}',
                      position: VxToastPosition.center);
                }),
            (context.screenWidth * .04).heightBox,
            CustomRadioButton(
              defaultSelected: widget.task.status,
              selectedBorderColor: Vx.hexToColor(Vx.grayHex200),
              unSelectedBorderColor: Vx.hexToColor('#c94b4b'),
              elevation: 0,
              width: MediaQuery.of(context).size.width * .43,
              absoluteZeroSpacing: false,
              unSelectedColor: Theme.of(context).canvasColor,
              buttonLables: const ['Yes', 'No'],
              buttonValues: const [true, false],
              enableShape: true,
              buttonTextStyle: const ButtonTextStyle(
                  selectedColor: Vx.gray400,
                  unSelectedColor: Colors.black,
                  textStyle: TextStyle(
                      color: Vx.gray600,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              radioButtonValue: (value) {
                _isCompleted = value as bool;
              },
              selectedColor: Vx.hexToColor(Vx.greenHex200),
            ).py(17.0),
            (context.screenWidth * .1).heightBox,
            ButtonWidget(
                buttonText: 'Update Task',
                buttonColor: Vx.hexToColor('#d9ed80'),
                onPressed: _updateData)
          ],
        ));
  }
}
