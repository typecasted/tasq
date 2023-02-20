import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/modules/sign_up/sign_up_screen.dart';

class SignInController extends GetxController {
  TextEditingController emailTextFieldController = TextEditingController();

  TextEditingController passwordTextFieldController = TextEditingController();

  void initSignInScreen() {
    emailTextFieldController = TextEditingController();
    passwordTextFieldController = TextEditingController();
  }

  void disposeSignInScreen() {
    emailTextFieldController.dispose();
    passwordTextFieldController.dispose();
  }

  void navigateToSignUpScreen({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }
}

SignInController signInController = Get.put(
  SignInController(),
);
