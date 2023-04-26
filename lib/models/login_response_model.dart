import 'dart:convert';
import 'user_model.dart';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  int? statusCode;
  UserModel? userDataModel;

  LoginResponseModel({
    this.statusCode,
    this.userDataModel,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    userDataModel = json['Model'] != null
        ? UserModel.fromJson(json['Model'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode ?? "";
    data['Model'] = userDataModel?.toJson() ?? {};
    return data;
  }
}
