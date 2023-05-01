/// package import
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// utils import
import '../utils/app_colors.dart';
import '../utils/fonts.gen.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.textEditingController,
    this.textInputAction,
    this.maxLines = 1,
    this.obscureText = false,
    this.enabled = true,
  });

  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final int maxLines;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        10,
      ),
      child: Container(
        // height: Get.height * 0.07,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColorLight,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04,
          ),
          child: TextFormField(
            enabled: enabled,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: Get.height * 0.02,
                color: AppColors.greyHintTextColor,
                fontFamily: FontFamily.poppins,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
            controller: textEditingController,
            obscureText: obscureText,
          ),
        ),
      ),
    );
  }
}
