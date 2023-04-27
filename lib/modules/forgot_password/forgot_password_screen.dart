import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/common_text_field.dart';
import 'package:tasq/utils/app_colors.dart';

import '../../common_widgets/common_button.dart';
import '../../utils/app_strings.dart';
import '../../utils/fonts.gen.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  @override
  void initState() {
    super.initState();
    forgotPasswordController.onInit();
  }

  @override
  void dispose() {
    forgotPasswordController.onClose();
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
          "Forgot Password",
          style: TextStyle(
              color: AppColors.primaryColor,

              // fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05,
          vertical: Get.height * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.enterYourEmailHere,
              style: TextStyle(
                fontSize: Get.height * 0.025,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            CommonTextField(
              hintText: "Email",
              textInputType: TextInputType.emailAddress,
              textEditingController:
                  forgotPasswordController.emailTextController,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),

            ListTile(
              splashColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              onTap: () {
                forgotPasswordController.onManagerCheckBoxChanged(
                  !forgotPasswordController.isManager.value,
                );
              },
              leading: Obx(
                () => Checkbox(
                  value: forgotPasswordController.isManager.value,
                  onChanged: (value) {
                    forgotPasswordController.onManagerCheckBoxChanged(value);
                  },
                  activeColor: AppColors.primaryColor,
                ),
              ),
              title: Text(
                AppStrings.loginAsManager,
                style: TextStyle(
                  fontSize: Get.height * 0.014,
                  color: AppColors.solidTextColor,
                  fontFamily: FontFamily.poppins,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            SizedBox(
              height: Get.height * 0.03,
            ),

            /// Submit Button
            Center(
              child: CommonButton(
                text: AppStrings.submit,
                onTap: () {
                  forgotPasswordController.onSubmitTap(
                    context: context,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
