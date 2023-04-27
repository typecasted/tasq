import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/common_button.dart';
import 'package:tasq/common_widgets/common_login_text_field.dart';
import 'package:tasq/common_widgets/common_text_field.dart';
import 'package:tasq/utils/assets.gen.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/fonts.gen.dart';
import 'add_user_controller.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late AddUserController addUserController;

  @override
  void initState() {
    super.initState();
    addUserController = Get.put(AddUserController());
    addUserController.onInit();
  }

  @override
  void dispose() {
    addUserController.onClose();
    addUserController.dispose();
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

      /// body
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
                      height: Get.height * 0.02,
                    ),
                    CommonLoginTextField(
                      hintText: "Email To",
                      iconPath: Assets.svgs.icMessage,
                      textInputType: TextInputType.emailAddress,
                      textEditingController:
                          addUserController.toEmailController,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CommonLoginTextField(
                      hintText: "Assignee Email",
                      iconPath: Assets.svgs.icMessage,
                      textInputType: TextInputType.emailAddress,
                      textEditingController:
                          addUserController.assigneeEmailController,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CommonLoginTextField(
                      hintText: "Designation",
                      iconPath: Assets.svgs.icPersonUnfilled,
                      textInputType: TextInputType.emailAddress,
                      textEditingController:
                          addUserController.designationController,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      AppStrings.remarks,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                        fontFamily: FontFamily.poppins,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CommonTextField(
                      hintText: "Type Here...",
                      textInputType: TextInputType.multiline,
                      textEditingController:
                          addUserController.remarksController,
                      maxLines: 7,
                      textInputAction: TextInputAction.newline,
                    ),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    CommonButton(
                      text: "Add User",
                      onTap: () {
                        addUserController.addUserButtonTap(context: context);
                      },
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
