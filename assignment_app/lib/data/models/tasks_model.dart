import 'dart:convert';

class TasksModel {
  final String id;
  final DateTime dueDate;
  final bool status;

  TasksModel({
    required this.id,
    required this.dueDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dueDate': dueDate.toString(),
      'status': status,
    };
  }

  factory TasksModel.fromMap(Map<String, dynamic> map) {
    return TasksModel(
      id: map['id'] ?? '',
      dueDate: DateTime.parse(map['dueDate']),
      status: map['status'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TasksModel.fromJson(String source) =>
      TasksModel.fromMap(json.decode(source));
}
