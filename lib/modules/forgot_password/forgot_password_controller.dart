import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailTextController = TextEditingController();

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

  void onSubmitTap() {
    if (validateFields()) {
      Get.back();
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
}
