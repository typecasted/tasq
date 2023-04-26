import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/common_text_field.dart';
import 'package:tasq/modules/forgot_password/send_otp_and_password_controller.dart';
import 'package:tasq/utils/app_strings.dart';

import '../../common_widgets/common_button.dart';
import '../../utils/app_colors.dart';

class SendOTPAndPasswordScreen extends StatefulWidget {
  final String email;

  const SendOTPAndPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<SendOTPAndPasswordScreen> createState() =>
      _SendOTPAndPasswordScreenState();
}

class _SendOTPAndPasswordScreenState extends State<SendOTPAndPasswordScreen> {
  SendOTPAndPasswordController sendOTPAndPasswordController =
      Get.put(SendOTPAndPasswordController());

  @override
  void initState() {
    super.initState();
    sendOTPAndPasswordController.onInit();
  }

  @override
  void dispose() {
    sendOTPAndPasswordController.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: AppColors.primaryColor,
        ),
        title: Text(
          "Verify OTP",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
            vertical: Get.height * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter the OTP sent to your email",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // OTP TextField
              SizedBox(
                height: Get.height * 0.03,
              ),

              CommonTextField(
                hintText: "OTP here",
                textInputType: TextInputType.text,
                textEditingController:
                    sendOTPAndPasswordController.otpTextController,
              ),

              // Password TextField
              SizedBox(
                height: Get.height * 0.03,
              ),

              CommonTextField(
                hintText: "New Password",
                textInputType: TextInputType.text,
                textEditingController:
                    sendOTPAndPasswordController.passwordTextController,
                obscureText: true,
              ),

              // Confirm Password TextField
              SizedBox(
                height: Get.height * 0.03,
              ),

              CommonTextField(
                hintText: "Confirm Password",
                textInputType: TextInputType.text,
                textEditingController:
                    sendOTPAndPasswordController.confirmPasswordTextController,
                obscureText: true,
              ),

              // Submit Button
              SizedBox(
                height: Get.height * 0.05,
              ),

              CommonButton(
                text: AppStrings.submit,
                onTap: () {
                  sendOTPAndPasswordController.onSubmitTap(
                      context: context, email: widget.email);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
