import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    nameController = TextEditingController(text: 'John Doe');
    numberController = TextEditingController(text: '+91 123 456 7890');
    emailController = TextEditingController(text: 'test@gmail.com');
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
