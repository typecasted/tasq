/// package imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// controllers
import '../../modules/sign_in/sign_in_controller.dart';

/// utils
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/assets.gen.dart';
import '../../utils/fonts.gen.dart';

/// widgets
import '../../common_widgets/common_button.dart';
import '../../common_widgets/common_login_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInController signInController = Get.put(SignInController());
  @override
  void initState() {
    signInController.initSignInScreen();

    super.initState();
  }

  @override
  void dispose() {
    signInController.disposeSignInScreen();
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
                    height: Get.height * 0.1,
                  ),

                  Text(
                    AppStrings.loginToYourAcc,
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
                    hintText: AppStrings.email,
                    iconPath: Assets.svgs.icMessage,
                    textInputType: TextInputType.emailAddress,
                    textEditingController:
                        signInController.emailTextFieldController,
                  ),

                  SizedBox(
                    height: Get.height * 0.03,
                  ),

                  CommonLoginTextField(
                    hintText: AppStrings.password,
                    iconPath: Assets.svgs.icLock,
                    textInputType: TextInputType.text,
                    textEditingController:
                        signInController.passwordTextFieldController,
                    obscureText: true,
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      signInController.navigateToForgotPasswordScreen(
                        context: context,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.01,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          AppStrings.forgotPassword,
                          style: TextStyle(
                            fontSize: Get.height * 0.013,
                            color: AppColors.primaryColor,
                            fontFamily: FontFamily.poppins,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: Get.height * 0.02,
                  ),

                  ListTile(
                    splashColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      signInController.onManagerCheckBoxChanged(
                        !signInController.isManager.value,
                      );
                    },
                    leading: Obx(
                      () => Checkbox(
                        value: signInController.isManager.value,
                        onChanged: (value) {
                          signInController.onManagerCheckBoxChanged(value);
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
                    height: Get.height * 0.02,
                  ),

                  CommonButton(
                    text: AppStrings.login,
                    onTap: () {
                      signInController.onLoginButtonTap(
                        context: context,
                      );
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
                              horizontal: Get.width * 0.02),
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
                          child: Divider(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      signInController.navigateToSignUpScreen(
                        context: context,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02,
                        vertical: Get.height * 0.03,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: AppStrings.dontHaveAnAcc,
                          style: TextStyle(
                            fontSize: Get.height * 0.014,
                            color: AppColors.solidTextColor,
                            fontFamily: FontFamily.poppins,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "\t\t${AppStrings.signUp}",
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
