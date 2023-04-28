import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tasq/models/login_response_model.dart';
import 'package:tasq/models/user_model.dart';
import '../../common_widgets/full_screen_loader.dart';
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
    required String firstName,
    required String lastName,
    required bool isManager,
    required String firmName,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/register",
        data: {
          "userName": userName,
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "isManager": isManager.toString(),
          "firmName": firmName,
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
    required bool isManager,
    required BuildContext context,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/login",
        data: {
          "email": email,
          "password": password,
          "isManager": isManager.toString(),
        },
      );
    } on Exception catch (e, s) {
      log("Repository - loginUser - error: $e", stackTrace: s);
    }

    log("Repository - loginUser - Response - status: ${response?.statusCode}");
    log("Repository - loginUser - Response - data: ${response?.body}");

    if (context.mounted) {
      hideFullScreenLoader(context: context);
    }

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

  /// - [verifyOTP] method is used for otp verification purpose.
  /// - it will require [email], [otp].
  /// - it will return the status code of the response as a [String]
  static Future<String?> verifyOTP({
    required String email,
    required String otp,
    required bool isManager,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/validate-email",
        data: {
          "email": email,
          "otp": otp,
          "isManager": isManager.toString(),
        },
      );
    } on Exception catch (e, s) {
      log("Repository - verifyOTP - error: $e", stackTrace: s);
    }

    log("Repository - verifyOTP - Response - status: ${response?.statusCode}");
    log("Repository - verifyOTP - Response - data: ${response?.body}");

    return jsonDecode(response?.body ?? "")["status_code"].toString();
  }

  /// - [forgotPassword] method is used to send an otp to the user's email from backend.
  /// - it will require [email].
  /// - it will return a [bool] value if the otp is sent successfully or not.
  static Future<bool> forgotPassword({
    required String email,
    required bool isManager,
    required BuildContext context,
  }) async {
    bool isSent = false;
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/forgot-password",
        data: {
          "email": email,
          "isManager": isManager.toString(),
        },
      );
    } on Exception catch (e, s) {
      log("Repository - forgotPassword - error: $e", stackTrace: s);
    }

    log("Repository - forgotPassword - Response - status: ${response?.statusCode}");
    log("Repository - forgotPassword - Response - data: ${response?.body}");

    /// if the status code is 200 then the otp is sent successfully and it will return true
    /// else it will return false
    if (response?.statusCode == 200) {
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
        isSent = true;
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response?.body ?? "",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
        );
      }
      isSent = false;
    }

    return isSent;
  }

  /// - [resetPassword] method is used to reset the password of the user.
  /// - it will require [email], [otp], [password].
  /// - it will return a [bool] value if the password is reset successfully or not.
  static Future<bool> resetPassword({
    required String email,
    required String otp,
    required String password,
    required bool isManager,
    required BuildContext context,
  }) async {
    bool hasReset = false;
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/reset-password",
        data: {
          "email": email,
          "otp": otp,
          "password": password,
          "isManager": isManager.toString(),
        },
      );
    } on Exception catch (e, s) {
      log("Repository - resetPassword - error: $e", stackTrace: s);
    }

    log("Repository - resetPassword - Response - status: ${response?.statusCode}");
    log("Repository - resetPassword - Response - data: ${response?.body}");

    /// if the status code is 200 then the password is reset successfully and it will return true
    /// else it will return false
    if (jsonDecode(response?.body ?? "")["status_code"] == 200) {
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

        hasReset = true;
      }
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

        hasReset = false;
      }
    }

    return hasReset;
  }

  /// ! - here [toEmail] is the new email to be added and [assigneeEmail] is the email to which the new email is to be assigned
  static Future<bool> addUser({
    required String managerEmail,
    required String toEmail,
    required String assigneeEmail,
    required String designation,
    required String remarks,
    required String firstName,
    required String lastName,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/add-user",
        data: {
          "managerEmail": managerEmail,
          "emailTo": assigneeEmail,
          "email": toEmail,
          "designation": designation,
          "note": remarks,
          "firstName": firstName,
          "lastName": lastName,
        },
      );
    } on Exception catch (e, s) {
      log("Repository - addUser - error: $e", stackTrace: s);
    }

    log("Repository - addUser - Response - status: ${response?.statusCode}");
    log("Repository - addUser - Response - data: ${response?.body}");

    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
