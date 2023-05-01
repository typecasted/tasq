import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/common_text_field.dart';
import 'package:tasq/modules/profile/my_profile/edit_profile_controller.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/fonts.gen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  // MyProfileController controller = Get.put(MyProfileController());

  late EditProfileController editProfileController;

  @override
  void initState() {
    editProfileController = Get.put(EditProfileController());
    editProfileController.initializeField();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          AppStrings.myProfile,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: FontFamily.poppins,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primaryColor,
              size: 18,
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.06,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: GetBuilder<EditProfileController>(
                    id: "editProfile",
                    init: editProfileController,
                    builder: (controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Stack(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  // editProfileController.pickImage();
                                },
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[300],
                                    // foregroundImage: editProfileController
                                    //         .profilePicFile.value.path.isEmpty
                                    //     ? null
                                    //     : FileImage(
                                    //         editProfileController
                                    //             .profilePicFile.value,
                                    //       ),

                                    child: Center(
                                      child: Text(
                                        editProfileController
                                            .firstNameController.text[0]
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                          fontFamily: FontFamily.poppins,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   right: Get.width * 0.32,
                              //   bottom: 0,
                              //   child: GestureDetector(
                              //     behavior: HitTestBehavior.translucent,
                              //     onTap: () {
                              //       // editProfileController.pickImage();
                              //     },
                              //     child: Icon(
                              //       Icons.edit_square,
                              //       color: AppColors.primaryColor,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          /// Name text and text field.
                          Text(
                            AppStrings.firstName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                              fontFamily: FontFamily.poppins,
                            ),
                          ),

                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          /// Name text field.
                          CommonTextField(
                            hintText: "Enter First Name",
                            textInputType: TextInputType.name,
                            textEditingController:
                                editProfileController.firstNameController,
                          ),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          /// Last name text and text field.

                          Text(
                            AppStrings.lastName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                              fontFamily: FontFamily.poppins,
                            ),
                          ),

                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          /// Last name text field.

                          CommonTextField(
                            hintText: "Enter Last Name",
                            textInputType: TextInputType.name,
                            textEditingController:
                                editProfileController.lastNameController,
                          ),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          /// Email text and text field.

                          Text(
                            AppStrings.email,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                              fontFamily: FontFamily.poppins,
                            ),
                          ),

                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          /// Email text field.

                          CommonTextField(
                            hintText: "Enter email",
                            textInputType: TextInputType.emailAddress,
                            textEditingController:
                                editProfileController.emailController,
                            enabled: false,
                          ),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          SizedBox(
                            height: Get.height * 0.1,
                          ),

                          /// Save button.
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              await editProfileController.updateProfile(
                                context: context,
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: Get.height * 0.06,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  AppStrings.save,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: FontFamily.poppins,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
