import 'package:assignment_app/data/models/tasks_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksLoading()){
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    
  }
}
