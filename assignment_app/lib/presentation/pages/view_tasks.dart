import 'package:assignment_app/logic/cubit/tasks_cubit.dart';
import 'package:assignment_app/presentation/pages/update_task.dart';
import 'package:assignment_app/presentation/widgets/task_tile_widget.dart';
import 'package:assignment_app/utils/functions.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewTasks extends StatefulWidget {
  const ViewTasks({Key? key}) : super(key: key);

  @override
  State<ViewTasks> createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {
  final ScrollController _controller = ScrollController();
  late final TasksCubit _cubit;
  bool? _filterFor;

  @override
  void initState() {
    super.initState();
    _cubit = TasksCubit();

    _controller.addListener(() async {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
        await loading('loading...');
        Future.delayed(1.seconds, () async {
          _cubit.insertContent(filterFor: _filterFor);
          await loading('', show: false);
        });
      }
    });
  }

  @override
  void dispose() {
    _cubit.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.hexToColor(Vx.whiteHex),
      appBar: VxAppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _cubit.init();
                },
                icon: Icon(
                  Icons.refresh,
                  color: Vx.hexToColor(Vx.grayHex500),
                  size: context.screenWidth * .08,
                )).px(context.screenWidth * .04)
          ],
          elevation: .0,
          backgroundColor: Vx.hexToColor('#d9ed80'),
          title: 'View Tasks'
              .text
              .headline5(context)
              .bold
              .hexColor(Vx.whiteHex)
              .make()),
      //
      body: BlocBuilder<TasksCubit, TasksState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is TasksFetched) {
            if (state.tasks.isEmpty) {
              return 'No Data Found'
                  .text
                  .headline5(context)
                  .bold
                  .hexColor('#d9ed80')
                  .makeCentered();
            }
          }

          if (state is TasksFetched) {
            return Stack(children: [
              ListView.builder(
                controller: _controller,
                itemCount: state.displayAbleCount,
                itemBuilder: (_, index) {
                  return GestureDetector(
                      onLongPress: () async {
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListTile(
                                title: 'Do you want delete this task ??'
                                    .text
                                    .headline6(context)
                                    .bold
                                    .hexColor(Vx.indigoHex500)
                                    .makeCentered(),
                                trailing: IconButton(
                                    onPressed: () async {
                                      final result = await checkForInternet();

                                      if (result) {
                                        await loading('deleting...');
                                        _cubit.deleteData(
                                            state.tasks[index].refrence!);
                                        await loading('', show: false);
                                        //
                                        showSnackbar(
                                            context: context,
                                            message: 'deleted successfully..');
                                        context.pop();
                                      } else {
                                        showSnackbar(
                                            context: context,
                                            message: 'error: no internet',
                                            isError: true);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Vx.hexToColor(Vx.redHex400),
                                    )),
                              )
                                  .box
                                  .rounded
                                  .hexColor(Vx.whiteHex)
                                  .size(context.screenWidth,
                                      context.screenHeight * .07)
                                  .make();
                            });
                      },
                      onTap: () {
                        context.nextPage(UpdateTask(
                            cubit: _cubit, task: state.tasks[index]));
                      },
                      child: TaskTileWidget(task: state.tasks[index]));
                },
              ),

              //
              Align(
                alignment: Alignment.bottomCenter,
                child: VStack([
                  'Filter Tasks'
                      .text
                      .headline5(context)
                      .bold
                      .hexColor('#d9ed80')
                      .makeCentered(),
                  CustomRadioButton(
                    selectedBorderColor: Vx.hexToColor(Vx.grayHex200),
                    unSelectedBorderColor: Vx.hexToColor('#c94b4b'),
                    elevation: 0,
                    width: MediaQuery.of(context).size.width * .43,
                    absoluteZeroSpacing: false,
                    unSelectedColor: Theme.of(context).canvasColor,
                    buttonLables: const ['Completed', 'Not Completed'],
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
                      _filterFor = value as bool;
                      _cubit.insertContent(filterFor: _filterFor);
                    },
                    selectedColor: Vx.hexToColor(Vx.greenHex200),
                  )
                ])
                    .box
                    .rounded
                    .hexColor(Vx.whiteHex)
                    .size(context.screenWidth * .9, context.screenHeight * .13)
                    .make()
                    .py(context.screenWidth * .021),
              )
            ]);
          } else if (state is TasksError) {
            return 'Error while fetching'
                .text
                .headline5(context)
                .bold
                .hexColor(Vx.redHex300)
                .makeCentered();
          }

          return VStack([
            const Spacer(),
            CircularProgressIndicator(
              color: Vx.hexToColor('#dafb50'),
              strokeWidth: 5.0,
              backgroundColor: Vx.hexToColor(Vx.whiteHex),
            ).centered(),
            const Spacer()
          ]);
        },
      ),
    );
  }
}
