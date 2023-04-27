import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/models/login_response_model.dart';
import 'package:tasq/modules/dashboard/dashboard.dart';
import 'package:tasq/modules/sign_up/sign_up_screen.dart';
import 'package:tasq/utils/app_colors.dart';
import 'package:tasq/utils/local_storage.dart';

import '../../common_widgets/full_screen_loader.dart';
import '../../utils/network_services/repository.dart';
import '../forgot_password/forgot_password_screen.dart';

class SignInController extends GetxController {
  TextEditingController emailTextFieldController = TextEditingController();

  TextEditingController passwordTextFieldController = TextEditingController();

  RxBool isManager = false.obs;

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

      LoginResponseModel? logInResponse = await Repository.loginUser(
        email: emailTextFieldController.text.trim(),
        password: passwordTextFieldController.text.trim(),
        context: context,
      );

      if (context.mounted) {
        hideFullScreenLoader(context: context);
      }

      if (logInResponse != null && context.mounted) {
        LocalStorage.saveUserData(
          data: logInResponse.userDataModel!,
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Dashboard();
            },
          ),
          (route) {
            return false;
          },
        );
      }
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

  void navigateToForgotPasswordScreen({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ForgotPasswordScreen();
        },
      ),
    );
  }

  void onManagerCheckBoxChanged(bool? value) {
    isManager.value = value ?? false;
  }
}
