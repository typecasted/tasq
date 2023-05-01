import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/models/user_model.dart';
import 'package:tasq/utils/app_colors.dart';
import 'package:tasq/utils/local_storage.dart';


class EditProfileController extends GetxController {
  UserModel userData = UserModel();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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

  updateProfile({required BuildContext context}) async {
    if (validateFields(context)) {
      showFullScreenLoader(context: context);
      userData.body!.model!.firstName = firstNameController.text;
      userData.body!.model!.lastName = lastNameController.text;
      userData.body!.model!.email = emailController.text;

      await LocalStorage.saveUserData(data: userData);

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
