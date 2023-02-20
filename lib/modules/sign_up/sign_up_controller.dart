import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
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
}

SignUpController signUpController = Get.put(
  SignUpController(),
);
