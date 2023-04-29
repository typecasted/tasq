import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/modules/task/models/task_model.dart';
import 'package:tasq/modules/task/task_details/task_details_controller.dart';
import 'package:tasq/utils/app_colors.dart';
import 'package:tasq/utils/app_strings.dart';
import 'package:tasq/utils/fonts.gen.dart';

import '../add_or_edit_task/add_task_screen.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskModel task;
  const TaskDetailsScreen({super.key, required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TaskDetailController taskDetailController;

  @override
  void initState() {
    super.initState();
    taskDetailController = Get.put(TaskDetailController());
    taskDetailController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.task.title ?? "Task Details",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.poppins,
          ),
        ),
        actions: [
          taskDetailController.isManager.value || widget.task.isPersonal!
              ? IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddOrEditTaskScreen(
                          isEdit: true,
                          task: widget.task,
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Start Date & End Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Start Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.poppins,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        "${widget.task.start!.day}/${widget.task.start!.month}/${widget.task.start!.year}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.poppins,
                        ),
                      ),
                    ],
                  ),

                  // End Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppStrings.end,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.poppins,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        "${widget.task.end!.day}/${widget.task.end!.month}/${widget.task.end!.year}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.poppins,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Divider(height: 30),

              Text(
                AppStrings.description,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.poppins,
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              Text(
                widget.task.description ?? "No Description",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppins,
                ),
              ),

              const Divider(height: 30),

              Text(
                AppStrings.status,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.poppins,
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.task.status ?? "No Status",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.poppins,
                    ),
                  ),

                  /// Action button

                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Task actions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.poppins,
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(height: 30),

              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  taskDetailController.onRemarksTap(context: context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.remarks,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.poppins,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        taskDetailController.onRemarksTap(
                          context: context,
                        );
                      },
                      icon: const Icon(
                        Icons.open_in_new_outlined,
                      ),
                    )
                  ],
                ),
              ),

              // // Progress bar
              // Text(
              //   AppStrings.progress,
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 15,
              //     fontWeight: FontWeight.w500,
              //     fontFamily: FontFamily.poppins,
              //   ),
              // ),

              // const SizedBox(
              //   height: 5,
              // ),

              // Row(
              //   children: [
              //     Expanded(
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(10),
              //         child: LinearProgressIndicator(
              //           value: 0.5,
              //           backgroundColor: Colors.grey[300],
              //           valueColor: AlwaysStoppedAnimation<Color>(
              //             AppColors.primaryColor,
              //           ),
              //           minHeight: 10,
              //         ),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     const Text(
              //       "50%",
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 15,
              //         fontWeight: FontWeight.w400,
              //         fontFamily: FontFamily.poppins,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
