import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/modules/sign_up/sign_up_screen.dart';
import 'package:tasq/utils/app_colors.dart';

import '../../common_widgets/full_screen_loader.dart';
import '../../utils/network_services/repository.dart';

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

  Future<void> onLoginButtonTap({required BuildContext context}) async {
    if (validateFields(context: context)) {
      showFullScreenLoader(context: context);

      await Repository.loginUser(
        email: emailTextFieldController.text.trim(),
        password: passwordTextFieldController.text.trim(),
      );
    }
  }

  bool validateFields({required BuildContext context}) {
    if (emailTextFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Email is required',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    }
    if (passwordTextFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Password is required',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    }
    return true;
  }
}
