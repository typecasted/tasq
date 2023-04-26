import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/modules/sign_in/sign_in_screen.dart';

import '../../utils/network_services/repository.dart';

class SendOTPAndPasswordController extends GetxController {
  TextEditingController otpTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    otpTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
  }

  @override
  void onClose() {
    otpTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.onClose();
  }

  Future<void> onSubmitTap({
    required BuildContext context,
    required String email,
  }) async {
    if (validateFields(context)) {
      showFullScreenLoader(context: context);
      bool hasReset = await Repository.resetPassword(
        email: email,
        otp: otpTextController.text.trim(),
        password: passwordTextController.text.trim(),
        context: context,
      );

      if (context.mounted) {
        hideFullScreenLoader(context: context);
      }

      if (hasReset) {
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
  }

  bool validateFields(BuildContext context) {
    if (otpTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter OTP"),
        ),
      );
      return false;
    } else if (passwordTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter password"),
        ),
      );
      return false;
    } else if (confirmPasswordTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter confirm password"),
        ),
      );
      return false;
    } else if (passwordTextController.text !=
        confirmPasswordTextController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password and confirm password does not match"),
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}
