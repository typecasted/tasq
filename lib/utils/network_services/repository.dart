import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tasq/models/login_response_model.dart';
import 'package:tasq/models/user_model.dart';
import '../app_colors.dart';
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
  /// - it will return a [LoginResponseModel] if the user is logged in successfully
  /// - it will return null if the user is not logged in successfully
  static Future<LoginResponseModel?> loginUser({
    required String email,
    required String password,
    required BuildContext context,
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

    if (jsonDecode(response?.body ?? "")["status_code"] == 200) {
      return loginResponseModelFromJson(response?.body ?? "");
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonDecode(response?.body ?? "")["message"],
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
        );
      }

      return null;
    }
  }

  static Future<String?> verifyOTP({
    required String email,
    required String otp,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/validate-email",
        data: {
          "email": email,
          "otp": otp,
        },
      );
    } on Exception catch (e, s) {
      log("Repository - verifyOTP - error: $e", stackTrace: s);
    }

    log("Repository - verifyOTP - Response - status: ${response?.statusCode}");
    log("Repository - verifyOTP - Response - data: ${response?.body}");

    return jsonDecode(response?.body ?? "")["status_code"].toString();
  }
}
