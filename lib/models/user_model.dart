import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? message;
  Body? body;

  UserModel({
    this.message,
    this.body,
  });

  UserModel copyWith({
    String? message,
    Body? body,
  }) =>
      UserModel(
        message: message ?? this.message,
        body: body ?? this.body,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "body": body?.toJson(),
      };
}

class Body {
  Model? model;

  Body({
    this.model,
  });

  Body copyWith({
    Model? model,
  }) =>
      Body(
        model: model ?? this.model,
      );

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        model: Model.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": model?.toJson(),
      };
}

class Model {
  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? profilePicture;
  String? firmName;
  String? email;
  String? password;
  List<User>? users;
  String? otp;
  bool? isVerified;
  int? completeTasks;
  int? totalTasks;
  String? designation;

  Model({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.profilePicture,
    this.firmName,
    this.email,
    this.password,
    this.totalTasks,
    this.users,
    this.otp,
    this.isVerified,
    this.completeTasks,
    this.designation,
  });

  Model copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? userName,
    String? profilePicture,
    String? firmName,
    String? email,
    String? password,
    int? totalTasks,
    List<User>? users,
    dynamic otp,
    bool? isVerified,
    int? completeTasks,
    String? designation,
  }) =>
      Model(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        userName: userName ?? this.userName,
        profilePicture: profilePicture ?? this.profilePicture,
        firmName: firmName ?? this.firmName,
        email: email ?? this.email,
        password: password ?? this.password,
        totalTasks: totalTasks ?? this.totalTasks,
        users: users ?? this.users,
        otp: otp ?? this.otp,
        isVerified: isVerified ?? this.isVerified,
        completeTasks: completeTasks ?? this.completeTasks,
        designation: designation ?? this.designation,
      );

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        profilePicture: json["profilePicture"],
        firmName: json["firmName"],
        email: json["email"],
        password: json["password"],
        totalTasks: json["totalTasks"],
        users: json["users"] == null
            ? <User>[]
            : List<User>.from(json["users"].map((x) => User.fromJson(x))),
        otp: json["otp"],
        isVerified: json["isVerified"],
        completeTasks: json["completeTasks"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "firmName": firmName,
        "email": email,
        "password": password,
        "totalTasks": totalTasks,
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
        "otp": otp,
        "isVerified": isVerified,
        "completeTasks": completeTasks,
        "designation": designation,
      };
}

class User {
  String? designation;
  String? email;

  User({
    this.designation,
    this.email,
  });

  User copyWith({
    String? designation,
    String? email,
  }) =>
      User(
        designation: designation ?? this.designation,
        email: email ?? this.email,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        designation: json["designation"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "designation": designation,
        "email": email,
      };
}
