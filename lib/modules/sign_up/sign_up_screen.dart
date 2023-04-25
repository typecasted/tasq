/// package import
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// controllers import
import './sign_up_controller.dart';


/// utils import
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/assets.gen.dart';
import '../../utils/fonts.gen.dart';

/// widgets import
import '../../common_widgets/common_button.dart';
import '../../common_widgets/common_login_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = Get.put(SignUpController());

  @override
  void initState() {
    super.initState();
    signUpController.onInit();
  }

  @override
  void dispose() {
    signUpController.onClose();
    signUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05,
              vertical: Get.height * 0.1,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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

                  Text(
                    AppStrings.createYourAcc,
                    style: TextStyle(
                      fontSize: Get.height * 0.02,
                      color: AppColors.solidTextColor,
                      fontFamily: FontFamily.poppins,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(
                    height: Get.height * 0.05,
                  ),

                  CommonLoginTextField(
                    hintText: AppStrings.username,
                    iconPath: Assets.svgs.icMessage,
                    textInputType: TextInputType.emailAddress,
                    textEditingController:
                        signUpController.userNameTextFieldController,
                  ),

                  SizedBox(
                    height: Get.height * 0.03,
                  ),

                  CommonLoginTextField(
                    hintText: AppStrings.email,
                    iconPath: Assets.svgs.icMessage,
                    textInputType: TextInputType.emailAddress,
                    textEditingController:
                        signUpController.emailTextFieldController,
                  ),

                  SizedBox(
                    height: Get.height * 0.03,
                  ),

                  CommonLoginTextField(
                    hintText: AppStrings.password,
                    iconPath: Assets.svgs.icLock,
                    textInputType: TextInputType.text,
                    textEditingController:
                        signUpController.passwordTextFieldController,
                    obscureText: true,
                  ),

                  SizedBox(
                    height: Get.height * 0.03,
                  ),

                  CommonLoginTextField(
                    hintText: AppStrings.confirmPassword,
                    iconPath: Assets.svgs.icLock,
                    textInputType: TextInputType.text,
                    textEditingController:
                        signUpController.confirmPasswordTextFieldController,
                    obscureText: true,
                  ),

                  SizedBox(
                    height: Get.height * 0.03,
                  ),

                  CommonButton(
                    text: AppStrings.register,
                    onTap: () {
                      signUpController.onRegisterButtonTap(context: context);
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                          child: Divider(color: AppColors.primaryColor),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.02,
                          ),
                          child: Text(
                            AppStrings.orLoginWith,
                            style: TextStyle(
                              fontSize: Get.height * 0.014,
                              color: AppColors.solidTextColor,
                              fontFamily: FontFamily.poppins,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                          child: Divider(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02,
                        vertical: Get.height * 0.03,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: AppStrings.alreadyHaveAnAccount,
                          style: TextStyle(
                            fontSize: Get.height * 0.014,
                            color: AppColors.solidTextColor,
                            fontFamily: FontFamily.poppins,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "\t\t${AppStrings.login}",
                              style: TextStyle(
                                fontSize: Get.height * 0.014,
                                color: AppColors.primaryColor,
                                fontFamily: FontFamily.poppins,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
