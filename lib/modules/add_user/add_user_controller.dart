import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';

class AddUserController extends GetxController {
  TextEditingController toEmailController = TextEditingController();
  TextEditingController assigneeEmailController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    toEmailController = TextEditingController();
    assigneeEmailController = TextEditingController();
    designationController = TextEditingController();
    remarksController = TextEditingController();
  }

  @override
  void onClose() {
    toEmailController.dispose();
    assigneeEmailController.dispose();
    designationController.dispose();
    remarksController.dispose();
    super.onClose();
  }

  void addUserButtonTap({
    required BuildContext context,
  }) {
    if (validateFields(
      context: context,
    )) {}
  }

  bool validateFields({required BuildContext context}) {
    if (toEmailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter email',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (assigneeEmailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter email',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (designationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter designation',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (remarksController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter remarks',
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
}
