import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  int? totalTasks;
  int? completeTasks;

  UserModel({
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.totalTasks,
    this.completeTasks,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    totalTasks = json['totalTasks'];
    completeTasks = json['completeTasks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userName'] = userName;
    data['email'] = email;
    data['totalTasks'] = totalTasks;
    data['completeTasks'] = completeTasks;
    return data;
  }
}
