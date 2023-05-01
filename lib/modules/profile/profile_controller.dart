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

  Future<void> fetchUserData({
    required BuildContext context,
  }) async {
    // userData.value = await Repository.getUserData(
    //   context: context,
    //   email: (await LocalStorage.getUserData())!.body!.model!.email ?? "",
    //   isManager: (await LocalStorage.getIsLoggedInAsManager()).toString(),
    // );

    // await LocalStorage.saveUserData(data: userData.value);

    userData.value = await LocalStorage.getUserData() ?? UserModel();
  }
}
