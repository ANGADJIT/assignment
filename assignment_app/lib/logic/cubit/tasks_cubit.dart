import 'package:assignment_app/data/models/tasks_model.dart';
import 'package:assignment_app/logic/database/task_db.dart';
import 'package:assignment_app/utils/functions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final TasksDb _tasksDb = TasksDb();
  int length = 0;
  List<TasksModel> _tasks = [];

  void init() async {
    checkForInternet().then((check) {
      if (check) {
        _tasksDb.getTasks().then((value) {
          _tasks = value;
          length = value.length;
          insertContent();
        });
      } else {
        emit(TasksError());
      }
    });
  }

  TasksCubit() : super(TasksLoading()) {
    init();
  }

  void insertContent({bool? filterFor}) {
    List<TasksModel> _filteredTask = _tasks;

    if (filterFor != null) {
      if (filterFor) {
        _filteredTask =
            _tasks.where((element) => element.status == true).toList();
      } else {
        _filteredTask =
            _tasks.where((element) => element.status == false).toList();
      }
      length = _filteredTask.length;
    }

    if (length >= 8) {
      length -= 8;
      emit(TasksLoading());
      emit(TasksFetched(tasks: _filteredTask, displayAbleCount: 8));
    } else {
      emit(TasksLoading());
      emit(TasksFetched(
          tasks: _filteredTask, displayAbleCount: _filteredTask.length));
    }
  }

  Future<void> deleteData(reference) async {
    emit(TasksLoading());
    await _tasksDb.deleteData(reference);
    init();
  }
}
