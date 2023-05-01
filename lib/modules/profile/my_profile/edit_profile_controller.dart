import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/models/user_model.dart';
import 'package:tasq/utils/app_colors.dart';
import 'package:tasq/utils/local_storage.dart';

import '../../../utils/network_services/repository.dart';

class EditProfileController extends GetxController {
  UserModel userData = UserModel();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController designationController = TextEditingController();

  // Rx<File> profilePicFile = File("").obs;

  FileImage? profilePic;

  Future<void> initializeField() async {
    userData = (await LocalStorage.getUserData())!;

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();

    // profilePicFile = File("").obs;

    firstNameController.text = userData.body!.model!.firstName ?? "";
    lastNameController.text = userData.body!.model!.lastName ?? "";
    emailController.text = userData.body!.model!.email ?? "";

    update(["editProfile"]);
  }

  // Future<void> pickImage() async {
  //   await ImagePicker().pickImage(source: ImageSource.gallery).then(
  //     (value) {
  //       if (value != null) {
  //         profilePic = FileImage(
  //           File(value.path),
  //         );
  //         profilePicFile.value = File(value.path);

  //         update(["editProfile"]);
  //       }
  //     },
  //   );
  // }

  updateProfile({required BuildContext context}) async {
    if (validateFields(context)) {
      showFullScreenLoader(context: context);
      userData.body!.model!.firstName = firstNameController.text;
      userData.body!.model!.lastName = lastNameController.text;
      userData.body!.model!.email = emailController.text;
      // userData.body!.model!.profilePicture = base64Encode(
      //   profilePicFile.value.readAsBytesSync(),
      // );

      await Repository.updateProfile(
        userData: userData,
        context: context,
        isManager: await LocalStorage.getIsLoggedInAsManager(),
      );

      hideFullScreenLoader(context: context);

      Navigator.pop(context);

      update(["editProfile"]);
    }
  }

  bool validateFields(BuildContext context) {
    if (firstNameController.text.isEmpty) {
      showSnackBar(context, "Please enter first name");
      return false;
    } else if (lastNameController.text.isEmpty) {
      showSnackBar(context, "Please enter last name");
      return false;
    } else {
      return true;
    }
  }

  void showSnackBar(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          s,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
