import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/modules/otp/otp_screen.dart';
import 'package:tasq/utils/app_colors.dart';
import 'package:tasq/utils/local_storage.dart';

import '../../utils/network_services/repository.dart';

class SignUpController extends GetxController {
  TextEditingController userNameTextFieldController = TextEditingController();
  TextEditingController emailTextFieldController = TextEditingController();
  TextEditingController passwordTextFieldController = TextEditingController();
  TextEditingController confirmPasswordTextFieldController =
      TextEditingController();
  TextEditingController firstNameTextFieldController = TextEditingController();
  TextEditingController lastNameTextFieldController = TextEditingController();
  TextEditingController companyNameTextFieldController =
      TextEditingController();

  RxBool isManager = false.obs;

  @override
  onInit() {
    super.onInit();
    userNameTextFieldController = TextEditingController();
    emailTextFieldController = TextEditingController();
    passwordTextFieldController = TextEditingController();
    confirmPasswordTextFieldController = TextEditingController();
    firstNameTextFieldController = TextEditingController();
    lastNameTextFieldController = TextEditingController();
    companyNameTextFieldController = TextEditingController();
  }

  @override
  void onClose() {
    userNameTextFieldController.dispose();
    emailTextFieldController.dispose();
    passwordTextFieldController.dispose();
    confirmPasswordTextFieldController.dispose();
    firstNameTextFieldController.dispose();
    lastNameTextFieldController.dispose();
    companyNameTextFieldController.dispose();
    super.onClose();
  }

  onRegisterButtonTap({required BuildContext context}) async {
    /// validate the fields first
    if (validateFields(context: context)) {
      showFullScreenLoader(context: context);

      /// call the api to register the user
      final response = await Repository.registerUser(
        firstName: firstNameTextFieldController.text,
        lastName: lastNameTextFieldController.text,
        userName: userNameTextFieldController.text,
        email: emailTextFieldController.text,
        password: passwordTextFieldController.text,
        isManager: isManager.isTrue,
        firmName: companyNameTextFieldController.text,
      );

      if (context.mounted) hideFullScreenLoader(context: context);

      if (response != null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Registration successful',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        }

        /// save the user data in local storage
        await LocalStorage.saveUserData(data: response);

        /// navigate to otp screen to verify the users otp.
        /// we are using [Navigator.pushAndRemoveUntil] to remove all the previous screens from the stack
        /// context is used to check if the screen is still mounted or not to avoid any errors
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                email: emailTextFieldController.text,
                isManager: isManager.isTrue,
                isFromLogin: false,
              ),
            ),
            (route) {
              return false;
            },
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Registration failed',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        }
      }
    }
  }

  bool validateFields({required BuildContext context}) {
    /// validate the fields here

    if (userNameTextFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter your username',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (firstNameTextFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter your first name',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (lastNameTextFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter your last name',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );

      return false;
    } else if (isManager.isTrue &&
        companyNameTextFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter your company name',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (emailTextFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter your email',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    }

    /// validate the email here
    else if (!GetUtils.isEmail(emailTextFieldController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter a valid email',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (passwordTextFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter your password',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (confirmPasswordTextFieldController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter your confirm password',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (passwordTextFieldController.text !=
        confirmPasswordTextFieldController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Password and confirm password does not match',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  void onManagerCheckBoxChanged(bool? bool) {
    isManager.value = bool!;
  }
}
