import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/task/models/task_model.dart';
import '../utils/app_colors.dart';
import '../utils/fonts.gen.dart';

class TaskDetailsTile extends StatelessWidget {
  const TaskDetailsTile({
    super.key,
    required this.taskDetails,
    required this.onTap,
  });

  final TaskModel taskDetails;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.01,
          // horizontal: Get.width * 0.02,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColorLight.withOpacity(0.5),
            border: Border.all(
              color: AppColors.primaryColor,
              width: 1,
            ),
          ),
          height: Get.height * 0.18,
          width: Get.width * 0.35,
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    taskDetails.title ?? "",
                    style: TextStyle(
                      fontFamily: FontFamily.poppins,
                      fontSize: Get.height * 0.019,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
    
                  /// Task Status
    
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02,
                        vertical: Get.height * 0.005),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primaryColor,
                    ),
                    child: Text(
                      taskDetails.status ?? "Task Status",
                      style: TextStyle(
                        fontFamily: FontFamily.poppins,
                        fontSize: Get.height * 0.015,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                taskDetails.description ?? "",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: FontFamily.poppins,
                  fontSize: Get.height * 0.015,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
