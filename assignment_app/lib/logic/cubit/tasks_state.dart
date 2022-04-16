part of 'tasks_cubit.dart';

abstract class TasksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TasksLoading extends TasksState {}

class TasksFetched extends TasksState {
  final List<TasksModel> tasks;
  final int displayAbleCount;

  TasksFetched({required this.tasks, required this.displayAbleCount});
}

class TasksError extends TasksState {}
