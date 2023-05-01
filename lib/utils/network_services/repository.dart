import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tasq/models/login_response_model.dart';
import 'package:tasq/models/remarks_list.dart';
import 'package:tasq/models/user_model.dart';
import '../../common_widgets/full_screen_loader.dart';
import '../../modules/otp/otp_screen.dart';
import '../../modules/task/models/task_model.dart';
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
    // required String userName,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required bool isManager,
    required String firmName,
    required BuildContext context,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/register",
        data: {
          // "userName": userName,
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

    if (context.mounted &&
        NetworkServices.checkResponse(
          response: response!,
          context: context,
        )) {
      return userModelFromJson(response.body);
    }
  }

  /// - [loginUser] is used to login a user
  /// - it will require [email], [password].
  /// - it will return a [LoginResponseModel] if the user is logged in successfully
  /// - it will return null if the user is not logged in successfully
  static Future<UserModel?> loginUser({
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

    if (context.mounted &&
        NetworkServices.checkResponse(
          response: response!,
          context: context,
        )) {
      return userModelFromJson(response.body);
    } else {
      /// [402] status code means that the user is not verified
      /// if the user is not verified then it will send the otp to the user
      if (response!.statusCode == 402) {
        late bool isSent;

        if (context.mounted) {
          showFullScreenLoader(context: context);
          isSent = await sendOTP(email: email, context: context);
          if (context.mounted) {
            hideFullScreenLoader(context: context);
          }
        }

        if (isSent && context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OTPScreen(
                  email: email,
                  isManager: isManager,
                  // isFromLogin: true,
                );
              },
            ),
          );
        }

        return null;
      }
    }
  }

  /// - [verifyOTP] method is used for otp verification purpose.
  /// - it will require [email], [otp].
  /// - it will return a [bool] value if the otp is verified successfully or not.
  static Future<bool?> verifyOTP({
    required String email,
    required String otp,
    required bool isManager,
    required BuildContext context,
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

    if (context.mounted &&
        NetworkServices.checkResponse(response: response!, context: context)) {
      return true;
    } else {
      return false;
    }

    // return jsonDecode(response?.body ?? "")["status_code"].toString();
  }

  /// - [forgotPassword] method is used to send an otp to the user's email from backend.
  /// - it will require [email].
  /// - it will return a [bool] value if the otp is sent successfully or not.
  static Future<bool> forgotPassword({
    required String email,
    required bool isManager,
    required BuildContext context,
  }) async {
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
    if (context.mounted &&
        NetworkServices.checkResponse(
          response: response!,
          context: context,
        )) {
      return true;
    } else {
      return false;
    }
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

    if (context.mounted &&
        NetworkServices.checkResponse(
          response: response!,
          context: context,
        )) {
      return true;
    } else {
      return false;
    }
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
    required BuildContext context,
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

    if (context.mounted &&
        NetworkServices.checkResponse(
          response: response!,
          context: context,
        )) {
      return true;
    } else {
      return false;
    }
  }

  /// - [sendOTP] is used to send the OTP when the user is trying to login and they are unverified.
  static Future<bool> sendOTP({
    required String email,
    required BuildContext context,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/send-otp",
        data: {
          "email": email,
        },
      );
    } on Exception catch (e, s) {
      log("Repository - sendOTP - error: $e", stackTrace: s);
    }

    log("Repository - sendOTP - Response - status: ${response?.statusCode}");
    log("Repository - sendOTP - Response - data: ${response?.body}");

    if (context.mounted &&
        NetworkServices.checkResponse(
          response: response!,
          context: context,
        )) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> addTask({
    required String email,
    required String title,
    required String description,
    required String start,
    required String end,
    required bool isPersonal,
    required BuildContext context,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/add-task",
        data: {
          "email": email,
          "title": title,
          "description": description,
          "start": start,
          "end": end,
          "isPersonal": isPersonal.toString(),
        },
      );
    } on Exception catch (e, s) {
      log("Repository - addTask - error: $e", stackTrace: s);
    }

    log("Repository - addTask - Response - status: ${response?.statusCode}");
    log("Repository - addTask - Response - data: ${response?.body}");

    if (context.mounted &&
        NetworkServices.checkResponse(
          response: response!,
          context: context,
        )) {
      return true;
    } else {
      return false;
    }
  }

  static Future< /* List<TaskModel>? */ dynamic> getTask({
    String? id,
    required String email,
    required bool isPersonal,
    required BuildContext context,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/get-task",
        data: {
          "_id": id ?? "",
          "email": email,
          "isPersonal": isPersonal.toString(),
        },
      );
    } on Exception catch (e, s) {
      log("Repository - getTask - error: $e", stackTrace: s);
    }

    log("Repository - getTask - Response - status: ${response?.statusCode}");
    log("Repository - getTask - Response - data: ${response?.body}");

    if (/* context.mounted && */
        NetworkServices.checkResponse(
      response: response!,
      context: context,
    )) {
      if (id == null) {
        return List<TaskModel>.from(
          jsonDecode(response.body)["tasks"].map(
            (x) => TaskModel.fromJson(x),
          ),
        );
      } else {
        return TaskModel.fromJson(
          jsonDecode(response.body)["tasks"][0],
        );
      }
    } else {
      return null;
    }
  }

  static Future<bool> editTask({
    required BuildContext context,
    required bool isPersonal,
    required String status,
    // required TaskModel taskModel,
    String? id,
    required String title,
    required String description,
    required String start,
    required String end,
    required String email,
    required String taskId,
    required bool isCompleted,
  }) async {
    Response? response;
    try {
      response = await NetworkServices.post(
        path: "/edit-task",
        data: {
          "_id": id ?? taskId,
          "email": email,
          "title": title,
          "description": description,
          "start": start,
          "end": end,
          "status": status,
          "isCompleted": isCompleted.toString(),
          "isPersonal": isPersonal.toString(),
        },
      );
    } on Exception catch (e, s) {
      log("Repository - updateTaskStatus - error: $e", stackTrace: s);
    }

    log("Repository - updateTaskStatus - Response - status: ${response?.statusCode}");
    log("Repository - updateTaskStatus - Response - data: ${response?.body}");

    if (context.mounted &&
        NetworkServices.checkResponse(
          response: response!,
          context: context,
        )) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<RemarksModel>> getRemarks({
    required String taskId,
    required BuildContext context,
  }) async {
    Response? response;

    try {
      response = await NetworkServices.post(
        path: "/get-remarks",
        data: {
          "taskId": taskId,
        },
      );
    } on Exception catch (e, s) {
      log("Repository - getRemarks - error: $e", stackTrace: s);
    }

    log("Repository - getRemarks - Response - status: ${response?.statusCode}");
    log("Repository - getRemarks - Response - data: ${response?.body}");

    if (NetworkServices.checkResponse(response: response!, context: context)) {
      return List<RemarksModel>.from(
        jsonDecode(response.body)["remarks"].map(
          (x) => RemarksModel.fromJson(x),
        ),
      );
    } else {
      return [];
    }
  }

  static Future<bool> addRemarks({
    required String taskId,
    required BuildContext context,
    required String message,
    required String email,
    required String dateTime,
  }) async {
    Response? response;

    try {
      response = await NetworkServices.post(
        path: "/add-remark",
        data: {
          "taskId": taskId,
          "message": message,
          "email": email,
          "dateTime": dateTime,
        },
      );
    } on Exception catch (e, s) {
      log("Repository - addRemarks - error: $e", stackTrace: s);
    }

    log("Repository - addRemarks - Response - status: ${response?.statusCode}");
    log("Repository - addRemarks - Response - data: ${response?.body}");

    if (NetworkServices.checkResponse(response: response!, context: context)) {
      return true;
    } else {
      return false;
    }
  }

  static updateProfile({
    required UserModel userData,
    required BuildContext context,
    required bool isManager,
  }) async {
    Response? response;

    try {
      response = await NetworkServices.post(
        path: "/update-user-profile",
        data: {
          "email": userData.body!.model!.email,
          "firstName": userData.body!.model!.firstName,
          "lastName": userData.body!.model!.lastName,
          "profilePicture": userData.body!.model!.profilePicture ?? "",
          "isManager": isManager.toString(),
          "firmName": userData.body!.model!.firmName ?? "",
          "designation": userData.body?.model?.designation ?? "",
        },
      );
    } on Exception catch (e, s) {
      log("Repository - updateProfile - error: $e", stackTrace: s);
    }

    log("Repository - updateProfile - Response - status: ${response?.statusCode}");
    log("Repository - updateProfile - Response - data: ${response?.body}");

    if (NetworkServices.checkResponse(
      response: response!,
      context: context,
    )) {
      return true;
    } else {
      return false;
    }
  }

  static Future<UserModel> getUserData({
    required String email,
    required String isManager,
    required BuildContext context,
  }) async {
    Response? response;

    try {
      response = await NetworkServices.post(
        path: "/get-user-profile",
        data: {
          "email": email,
          "isManager": isManager,
        },
      );
    } on Exception catch (e, s) {
      log("Repository - getUserData - error: $e", stackTrace: s);
    }

    log("Repository - getUserData - Response - status: ${response?.statusCode}");
    log("Repository - getUserData - Response - data: ${response?.body}");

    if (NetworkServices.checkResponse(
      response: response!,
      context: context,
    )) {
      return UserModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      return UserModel();
    }
  }

  static deleteUser({
    required BuildContext context,
    required String email,
    required String userEmail,
  }) async {
    Response? response;

    try {
      response = await NetworkServices.post(
        path: "/delete-user",
        data: {
          "email": email,
          "userEmail": userEmail,
        },
      );
    } on Exception catch (e, s) {
      log("Repository - deleteUser - error: $e", stackTrace: s);
    }

    log("Repository - deleteUser - Response - status: ${response?.statusCode}");
    log("Repository - deleteUser - Response - data: ${response?.body}");

    if (NetworkServices.checkResponse(
      response: response!,
      context: context,
    )) {
      return true;
    } else {
      return false;
    }
  }
}
