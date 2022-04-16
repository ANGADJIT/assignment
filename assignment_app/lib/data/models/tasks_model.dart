import 'dart:convert';

class TasksModel {
  final String id;
  final DateTime dueDate;
  final bool status;
  dynamic refrence;
  final String upperKey;
  final String lowerKey;

  TasksModel({
    required this.id,
    required this.lowerKey,
    required this.upperKey,
    required this.dueDate,
    this.refrence,
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
        upperKey: map['upperKey'],
        refrence: map['ref'],
        lowerKey: map['lowerKey']);
  }

  String toJson() => json.encode(toMap());

  factory TasksModel.fromJson(String source) =>
      TasksModel.fromMap(json.decode(source));
}
