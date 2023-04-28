import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/models/user_model.dart';

import '../../utils/local_storage.dart';
import '../sign_in/sign_in_screen.dart';

class ProfileController extends GetxController {
  Rx<UserModel> userData = UserModel().obs;
  RxBool isLoggedInAsManager = false.obs;

  @override
  onInit() async {
    super.onInit();
    initProfileScreen();
  }

  Future<void> logout({required BuildContext context}) async {
    await LocalStorage.resetLocalStorage();

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const SignInScreen();
          },
        ),
        (route) => false,
      );
    }
  }

  Future<void> initProfileScreen() async {
    isLoggedInAsManager.value = await LocalStorage.getIsLoggedInAsManager();
    userData.value = await LocalStorage.getUserData() ?? UserModel();
  }
}
