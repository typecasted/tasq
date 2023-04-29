import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:tasq/common_widgets/common_button.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/fonts.gen.dart';
import 'otp_controller.dart';

class OTPScreen extends StatefulWidget {
  final String email;

  final bool isManager;

  // final bool isFromLogin;

  /// - [OTPScreen] screen is used to verify the otp sent to the user's email address.
  /// - it will require the email to pass to the [OTPController] to verify the otp for given email.
  const OTPScreen({
    super.key,
    required this.email,
    required this.isManager,
    // required this.isFromLogin,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  OTPController otpController = Get.put(OTPController());

  @override
  void initState() {
    super.initState();
    otpController.onInit();
  }

  @override
  dispose() {
    otpController.onClose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05,
          vertical: Get.height * 0.1,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// App Name
                Column(
                  children: [
                    Text(
                      AppStrings.appName,
                      style: TextStyle(
                        fontSize: Get.height * 0.04,
                        color: AppColors.primaryColor,
                        fontFamily: FontFamily.righteous,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppStrings.managementApp,
                      style: TextStyle(
                        fontSize: Get.height * 0.02,
                        color: AppColors.greyHintTextColor,
                        fontFamily: FontFamily.poppins,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: Get.height * 0.07,
                ),

                Center(
                  child: Text(
                    AppStrings.verifyAccount,
                    style: TextStyle(
                      fontSize: Get.height * 0.02,
                      color: AppColors.solidTextColor,
                      fontFamily: FontFamily.poppins,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.05,
                ),

                Center(
                  child: Text(
                    AppStrings.enterVerificationNumber,
                    style: TextStyle(
                      fontSize: Get.height * 0.015,
                      color: AppColors.solidTextColor,
                      fontFamily: FontFamily.poppins,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.05,
                ),

                OTPTextField(
                    controller: otpController.otpTextController,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    keyboardType: TextInputType.text,
                    fieldStyle: FieldStyle.underline,
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: AppColors.primaryColor,
                    ),
                    outlineBorderRadius: 15,
                    style: const TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      log("Changed: $pin");
                      otpController.otpString = pin;
                    },
                    onCompleted: (pin) {
                      log("Completed: $pin");
                    }),

                SizedBox(
                  height: Get.height * 0.03,
                ),

                /// Resend OTP
                Align(
                  alignment: Alignment.centerRight,
                  child: Center(
                    child: Text(
                      AppStrings.resendOTP,
                      style: TextStyle(
                        fontSize: Get.height * 0.015,
                        color: AppColors.solidTextColor,
                        fontFamily: FontFamily.poppins,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                /// Continue Button
                SizedBox(
                  height: Get.height * 0.05,
                ),

                CommonButton(
                  text: AppStrings.confirm,
                  onTap: () {
                    otpController.onConfirmButtonTap(
                      context: context,
                      email: widget.email,
                      isManager: widget.isManager,
                      // isFromLogin: widget.isFromLogin,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
