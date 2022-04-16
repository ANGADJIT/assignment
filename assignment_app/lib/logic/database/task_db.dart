import 'package:assignment_app/data/models/tasks_model.dart';
import 'package:assignment_app/logic/cubit/tasks_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TasksDb {
  final CollectionReference _instance =
      FirebaseFirestore.instance.collection('users');

  /// This adds task into firestore
  /// It accepts task model object
  Future<void> addTask(TasksModel task) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> data = {
      'task_${task.dueDate.year}_${task.dueDate.month}': {
        '${task.id}_Task_${task.dueDate.year}_${task.dueDate.month}':
            task.toMap()
      }
    };

    await _instance.doc(uid).collection('tasks').add(data);
  }

  /// This get all tasks from firestore
  ///
  /// And return List of [TasksModel] which is used by [TasksCubit]
  Future<List<TasksModel>> getTasks() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final tasksRef = await _instance.doc(uid).collection('tasks').get();
    final tasks = tasksRef.docs;

    List<TasksModel> _modeledTasks = [];

    for (var task in tasks) {
      final upperElement = task.get(task.data().keys.first);
      final data = upperElement[upperElement.keys.first];
      data['lowerKey'] = upperElement.keys.first;
      data['ref'] = task.reference;
      data['upperKey'] = task.data().keys.first;

      _modeledTasks.add(TasksModel.fromMap(data));
    }

    // sort by data
    _modeledTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));

    return _modeledTasks;
  }

  /// This is for delete the data from firestore
  /// Accepts refrence
  Future<void> deleteData(dynamic reference) async {
    await reference.delete();
  }

  /// This is for update the data from firestore
  /// Accepts refrence and Map data
  Future<void> updateData(
      {required Map<String, dynamic> data, required dynamic reference}) async {
    await reference.update(data);
  }
}
