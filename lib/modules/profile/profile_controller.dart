import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/local_storage.dart';
import '../sign_in/sign_in_screen.dart';

class ProfileController extends GetxController {



  Future<void> logout({required BuildContext context}) async {
    await LocalStorage.deleteUserData();

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
}
