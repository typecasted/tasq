import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasq/models/user_model.dart';

class LocalStorage {
  static const String userData = "userData";
  static const String loggedInAsManager = "loggedInAsManager";

  static Future<void> initLocalStorage() async {
    await Hive.initFlutter();
  }

  /// - [saveUserData] is used to save the user data in local storage
  /// - it will require [data] which is of type [UserModel]
  static Future<void> saveUserData({
    required UserModel data,
  }) async {
    final box = await Hive.openBox(userData);
    await box.put(userData, data.toJson());
  }

  /// - [getUserData] is used to get the user data from local storage
  /// - it will return a [UserModel] if the user data is found in local storage else it will return null
  static Future<UserModel?> getUserData() async {
    final box = await Hive.openBox(userData);
    final data = await box.get(userData);
    if (data != null) {
      return userModelFromJson(jsonEncode(data));
    }
    return null;
  }

  /// - [deleteUserData] is used to delete the user data from local storage
  /// - it will return a [bool] if the user data is deleted from local storage
  /// - it will return false if the user data is not found in local storage
  static Future<bool> deleteUserData() async {
    final box = await Hive.openBox(userData);
    final data = box.get(userData);
    if (data != null) {
      await box.delete(userData);
      return true;
    }
    return false;
  }

  /// - [getIsLoggedInAsManager] is used to check if the user is logged in as manager
  /// - it will return a [bool] if the user is logged in as manager
  static Future<bool> getIsLoggedInAsManager() async {
    final box = await Hive.openBox(loggedInAsManager);
    final data = box.get(loggedInAsManager);
    if (data != null) {
      return data;
    }
    return false;
  }

  /// - [setIsLoggedInAsManager] is used to set the user is logged in as manager
  /// - it will require [isLoggedInAsManager] which is of type [bool]
  static Future<void> setIsLoggedInAsManager({
    required bool isLoggedInAsManager,
  }) async {
    final box = await Hive.openBox(loggedInAsManager);
    await box.put(loggedInAsManager, isLoggedInAsManager);
  }

  /// [isUserLoggedIn] is used to check if the user is logged in
  /// - it will return a [bool] if the user is logged in
  static Future<bool> isUserLoggedIn() async {
    final box = await Hive.openBox(userData);
    final data = box.get(userData);
    if (data != null) {
      return true;
    }
    return false;
  }

  /// - [resetLocalStorage] is used to reset the local storage
  /// - it will delete the local storage boxes
  /// ! - make sure to call this method when the user logs out
  /// ! - and to delete all the boxes from local storage
  static resetLocalStorage() async {
    await Hive.deleteBoxFromDisk(userData);
    await Hive.deleteBoxFromDisk(loggedInAsManager);
  }
}
