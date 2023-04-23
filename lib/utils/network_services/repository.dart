import 'dart:developer';

import 'package:http/http.dart';
import 'package:tasq/models/user_model.dart';

import './network_services.dart';

class Repository {
  /// - [dryRunApi] is used to test the connection with the backend
  static dryRunApi() async {
    Response? response;
    try {
      response = await NetworkServices.get(
        path: "/",
      );
    } on Exception catch (e, s) {
      log("Repository - getHomePage -error: $e", stackTrace: s);
    }

    log("Repository - getHomePage - response - status: ${response?.statusCode}");
    log("Repository - getHomePage - response - data: ${response?.body}");
  }

  /// - [registerUser] is used to register a new user
  /// - it will require [userName], [email], [password].
  /// - it will return a [UserModel] if the user is registered successfully
  static Future<UserModel?> registerUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/register",
        data: {
          "userName": userName,
          "email": email,
          "password": password,
        },
      );
    } on Exception catch (e, s) {
      log("Repository - registerUser - error: $e", stackTrace: s);
    }

    log("Repository - registerUser - Response - status: ${response?.statusCode}");
    log("Repository - registerUser - Response - data: ${response?.body}");

    return userModelFromJson(response?.body ?? "");
  }

  /// - [loginUser] is used to login a user
  /// - it will require [email], [password].
  /// - it will return a [UserModel] if the user is logged in successfully
  /// - it will return null if the user is not logged in successfully
  static loginUser({
    required String email,
    required String password,
  }) async {

    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/login",
        data: {
          "email": email,
          "password": password,
        },
      );
    } on Exception catch (e, s) {
      log("Repository - loginUser - error: $e", stackTrace: s);
    }

    log("Repository - loginUser - Response - status: ${response?.statusCode}");
    log("Repository - loginUser - Response - data: ${response?.body}");

    return userModelFromJson(response?.body ?? "");
  }
}
