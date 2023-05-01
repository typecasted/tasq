import 'dart:convert';

RemarksModel remarksModelFromJson(String str) => RemarksModel.fromJson(
      json.decode(str),
    );

String remarksModelToJson(RemarksModel data) => json.encode(
      data.toJson(),
    );

class RemarksModel {
  String? id;
  String? email;
  String? message;
  DateTime? dateTime;

  RemarksModel({
    this.id,
    this.email,
    this.message,
    this.dateTime,
  });

  RemarksModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    message = json['message'];
    dateTime = DateTime.parse(json['dateTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'message': message,
      'dateTime': dateTime?.toIso8601String() ?? "",
    };
  }
}
