import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/utils/network_services/repository.dart';

import '../../utils/app_colors.dart';

class AddUserController extends GetxController {
  TextEditingController toEmailController = TextEditingController();
  TextEditingController assigneeEmailController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    toEmailController = TextEditingController();
    assigneeEmailController = TextEditingController();
    designationController = TextEditingController();
    remarksController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
  }

  @override
  void onClose() {
    toEmailController.dispose();
    assigneeEmailController.dispose();
    designationController.dispose();
    remarksController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }

  Future<void> addUserButtonTap({
    required BuildContext context,
    required String managerEmail,
  }) async {
    if (validateFields(
      context: context,
    )) {
      showFullScreenLoader(context: context);

      bool isSent = await Repository.addUser(
        managerEmail: managerEmail,
        toEmail: toEmailController.text,
        assigneeEmail: assigneeEmailController.text,
        designation: designationController.text,
        remarks: remarksController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        context: context,
      );

      log("AddUserController - addUserButtonTap - isSent: $isSent");

      if (context.mounted) {
        hideFullScreenLoader(context: context);
        Navigator.pop(context);
      }
    }
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
