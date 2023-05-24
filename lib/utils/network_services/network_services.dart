import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app_colors.dart';

class NetworkServices {
  /// - [baseUrl] is the base url of the backend
  static const String baseUrl = "http://192.168.138.205:3000";

  /// - [checkResponse] is used to check the response of the backend
  /// - [response] is the response of the backend
  /// - [context] is the context of the screen
  /// - [return] is a boolean value
  /// - [true] if the response is 200
  /// - [false] if the response is not 200
  /// - [ScaffoldMessenger.of(context).showSnackBar] is used to show a snackbar
  static bool checkResponse({
    required http.Response response,
    required BuildContext context,
  }) {
    switch (response.statusCode) {
      case 200:
        log("NetworkServices: checkResponse - 200");
        if (jsonDecode(response.body)["message"] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                jsonDecode(response.body)["message"] ?? "",
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        }
        return true;
      case 402:
        log("NetworkServices: checkResponse - 402");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonDecode(response.body)["message"],
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
        );
        return false;

      default:
        log("NetworkServices: checkResponse - default");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonDecode(response.body)["message"],
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
        );
        return false;
    }
  }

  static Future<http.Response?> get({
    required String path,
  }) async {
    http.Response? response;
    try {
      log("NetworkServices: get");
      log("path: $path");
      response = await http.get(Uri.parse(baseUrl + path));
    } on Exception catch (e) {
      log("NetworkServices: get - Exception - ${e.toString()}");
    }

    return response;
  }

  static Future<http.Response?> post(
      {required String path, required Map<String, dynamic> data}) async {
    http.Response? response;
    try {
      log("NetworkServices: post");
      log("path: $path");
      log("data: $data");
      response = await http.post(Uri.parse(baseUrl + path), body: data);
    } on Exception catch (e) {
      log("NetworkServices: post - ${e.toString()}");
    }

    return response;
  }

  static Future<http.Response?> put(
      {required String path, required Map<String, dynamic> data}) async {
    http.Response? response;
    try {
      response = await http.put(Uri.parse(baseUrl + path), body: data);
    } on Exception catch (e) {
      log("NetworkServices: put - ${e.toString()}");
    }

    return response;
  }

  static Future<http.Response?> delete({
    required String path,
  }) async {
    http.Response? response;
    try {
      response = await http.delete(Uri.parse(baseUrl + path));
    } on Exception catch (e) {
      log("NetworkServices: delete - ${e.toString()}");
    }

    return response;
  }
}
