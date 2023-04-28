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
  bool? isVerified;
  List<Users>? users;

  UserModel({
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.totalTasks,
    this.completeTasks,
    this.isVerified,
    this.users,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    totalTasks = json['totalTasks'];
    completeTasks = json['completeTasks'];
    isVerified = json['isVerified'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((dynamic v) {
        users?.add(Users.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName ?? "";
    data['lastName'] = lastName ?? "";
    data['userName'] = userName ?? "";
    data['email'] = email ?? "";
    data['totalTasks'] = totalTasks ?? 0;
    data['completeTasks'] = completeTasks ?? 0;
    data['isVerified'] = isVerified ?? false;
    if (users != null) {
      data['users'] = users?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? email;
  String? designation;

  Users({
    this.email,
    this.designation,
  });

  Users.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email ?? "";
    data['designation'] = designation ?? "";
    return data;
  }
}
