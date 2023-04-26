import 'dart:developer';
import 'package:http/http.dart' as http;

class NetworkServices {
  /// - [baseUrl] is the base url of the backend
  static const String baseUrl = "http://192.168.194.205:3000";

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
