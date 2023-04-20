import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/common_text_field.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/fonts.gen.dart';
import 'my_profile_controller.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  MyProfileController controller = Get.put(MyProfileController());

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  dispose() {
    controller.onClose();
    controller.dispose();
    super.dispose();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),

                    /// Name text and text field.

                    Text(
                      AppStrings.name,
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
                      hintText: "Enter text field",
                      textInputType: TextInputType.name,
                      textEditingController: controller.nameController,
                    ),

                    SizedBox(
                      height: Get.height * 0.02,
                    ),

                    /// Number text and text field.

                    Text(
                      AppStrings.number,
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

                    /// Number text field.

                    CommonTextField(
                      hintText: "Enter text field",
                      textInputType: TextInputType.number,
                      textEditingController: controller.numberController,
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
                      hintText: "Enter text field",
                      textInputType: TextInputType.emailAddress,
                      textEditingController: controller.emailController,
                    ),

                    SizedBox(
                      height: Get.height * 0.1,
                    ),

                    /// Save button.

                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.pop(context);
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
