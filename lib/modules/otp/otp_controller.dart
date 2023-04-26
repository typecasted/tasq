import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/modules/dashboard/dashboard.dart';
import 'package:tasq/utils/network_services/repository.dart';

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
  }) async {
    showFullScreenLoader(context: context);

    /// Verify OTP API call
    String? responseStatusCode = await Repository.verifyOTP(
      email: email,
      otp: otpString,
    );

    if (context.mounted) {
      hideFullScreenLoader(context: context);
    }

    /// If response status code is 200 then navigate to dashboard
    if (responseStatusCode != null && responseStatusCode == "200") {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Dashboard();
            },
          ),
          (route) => false,
        );
      }
    }
  }
}
