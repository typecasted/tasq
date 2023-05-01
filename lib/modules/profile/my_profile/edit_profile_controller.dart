import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/models/user_model.dart';
import 'package:tasq/utils/local_storage.dart';

class EditProfileController extends GetxController {
  UserModel userData = UserModel();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController designationController = TextEditingController();

  RxString profilePicString = "".obs;

  @override
  void onInit() {
    super.onInit();
    initializeField();
  }

  Future<void> initializeField() async {
    final userData = await LocalStorage.getUserData();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();

    profilePicString = "".obs;

    firstNameController.text = userData!.body!.model!.firstName ?? "";
    lastNameController.text = userData.body!.model!.lastName ?? "";
    emailController.text = userData.body!.model!.email ?? "";

    update(["editProfile"]);
  }
}
