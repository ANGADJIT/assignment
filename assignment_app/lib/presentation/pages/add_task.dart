import 'package:assignment_app/data/models/tasks_model.dart';
import 'package:assignment_app/logic/database/task_db.dart';
import 'package:assignment_app/presentation/widgets/button_widget.dart';
import 'package:assignment_app/utils/functions.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _task = TextEditingController();
  DateTime? _time;
  bool _isCompleted = true;
  final TasksDb _tasksDb = TasksDb();

  Future<void> _addTask() async {
    final result = await checkForInternet();

    if (result) {
      // validate data first
      if (_time == null || _task.text.isEmpty) {
        showSnackbar(
            context: context,
            message: 'error: fields required..',
            isError: true);
      } else {
        TasksModel task = TasksModel(
            id: _task.text,
            dueDate: _time!,
            status: _isCompleted,
            upperKey: '',
            lowerKey: '');

        await loading('Uploading tasks...');
        await _tasksDb.addTask(task);
        await loading('', show: false);

        showSnackbar(context: context, message: 'Uploaded successfully');
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
        title: 'Add Task'
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
            hint: 'Enter task',
            controller: _task,
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
            defaultSelected: true,
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
              buttonText: 'Save Task',
              buttonColor: Vx.hexToColor('#d9ed80'),
              onPressed: _addTask)
        ],
      ),
    );
  }
}
