import 'package:assignment_app/data/models/tasks_model.dart';
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

  Future<void> getData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final data = await _instance.doc(uid).collection('tasks').get();
    final d = data.docs[0].data();

    print(d[d.keys.first]);
  }
}
