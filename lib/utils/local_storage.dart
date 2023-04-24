import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasq/models/user_model.dart';

class LocalStorage {
  static const String userData = "userData";
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
    final data = box.get(userData);
    if (data != null) {
      return userModelFromJson(data);
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
}
