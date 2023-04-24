import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class OTPController extends GetxController {
  OtpFieldController otpTextController = OtpFieldController();

  @override
  void onInit() {
    super.onInit();
    otpTextController = OtpFieldController();
  }
}
