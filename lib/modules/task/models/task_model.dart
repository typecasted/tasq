import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  String? id;
  String? email;
  String? title;
  String? description;
  DateTime? start;
  DateTime? end;
  String? status;
  bool? isCompleted;
  bool? isPersonal;

  TaskModel({
    this.id,
    this.email,
    this.title,
    this.description,
    this.start,
    this.end,
    this.status,
    this.isCompleted,
    this.isPersonal,
  });

  TaskModel copyWith({
    String? id,
    String? email,
    String? title,
    String? description,
    DateTime? start,
    DateTime? end,
    String? status,
    bool? isCompleted,
    bool? isPersonal,
  }) =>
      TaskModel(
        id: id ?? this.id,
        email: email ?? this.email,
        title: title ?? this.title,
        description: description ?? this.description,
        start: start ?? this.start,
        end: end ?? this.end,
        status: status ?? this.status,
        isCompleted: isCompleted ?? this.isCompleted,
        isPersonal: isPersonal ?? this.isPersonal,
      );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["_id"],
        email: json["email"],
        title: json["title"],
        description: json["description"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        status: json["status"],
        isCompleted: json["isCompleted"],
        isPersonal: json["isPersonal"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "title": title,
        "description": description,
        "start": start?.toIso8601String(),
        "end": end?.toIso8601String(),
        "status": status,
        "isCompleted": isCompleted,
        "isPersonal": isPersonal,
      };
}
