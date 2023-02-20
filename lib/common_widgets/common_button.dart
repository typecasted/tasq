/// package imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// utils import
import '../utils/app_colors.dart';
import '../utils/fonts.gen.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: AppColors.primaryColor,
        ),
        child: SizedBox(
          height: Get.height * 0.07,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: Get.height * 0.02,
                color: Colors.white,
                fontFamily: FontFamily.poppins,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
