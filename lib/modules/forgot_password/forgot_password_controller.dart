import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/modules/forgot_password/send_otp_and_password_screen.dart';
import 'package:tasq/utils/network_services/repository.dart';

import '../../common_widgets/full_screen_loader.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailTextController = TextEditingController();

  RxBool isManager = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailTextController = TextEditingController();
  }

  @override
  void onClose() {
    emailTextController.dispose();
    super.onClose();
  }

  Future<void> onSubmitTap({
    required BuildContext context,
  }) async {
    if (validateFields()) {
      showFullScreenLoader(context: context);

      /// Forgot password API call
      bool isOTPSent = await Repository.forgotPassword(
        email: emailTextController.text.trim(),
        isManager: isManager.isTrue,
        context: context,
      );

      if (context.mounted) {
        hideFullScreenLoader(context: context);
      }

      /// If OTP is sent then navigate to send OTP and password screen
      if (isOTPSent) {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SendOTPAndPasswordScreen(
                  email: emailTextController.text.trim(),
                  isManager: isManager.isTrue,
                );
              },
            ),
          );
        }
      }
    }
  }

  bool validateFields() {
    if (emailTextController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Please enter email"),
        ),
      );
      return false;
    } else if (!GetUtils.isEmail(emailTextController.text)) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Please enter valid email"),
        ),
      );

      return false;
    }
    return true;
  }

  void onManagerCheckBoxChanged(bool? bool) {
    isManager.value = bool!;
  }
}
