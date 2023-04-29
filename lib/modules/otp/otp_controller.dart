import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/utils/app_colors.dart';
import 'package:tasq/utils/network_services/repository.dart';

import '../sign_in/sign_in_screen.dart';

class OTPController extends GetxController {
  OtpFieldController otpTextController = OtpFieldController();

  String otpString = "";

  @override
  void onInit() {
    super.onInit();
    otpTextController = OtpFieldController();
  }

  Future<void> onConfirmButtonTap({
    required BuildContext context,
    required String email,
    required bool isManager,
    // required bool isFromLogin,
  }) async {
    showFullScreenLoader(context: context);

    bool? isVerified;
    if (validateFields(context)) {
      /// Verify OTP API call
      isVerified = await Repository.verifyOTP(
        email: email,
        otp: otpString,
        isManager: isManager,
        context: context,
      );
    }

    if (context.mounted) {
      hideFullScreenLoader(context: context);
    }

    /// if isVerified is true then navigate to [SignInScreen] screen to log in the user.
    if (isVerified ?? false) {
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

  bool validateFields(BuildContext context) {
    if (otpString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Please enter OTP",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    }
    return true;
  }
}
