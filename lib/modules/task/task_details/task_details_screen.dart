import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/modules/task/task_details/task_details_controller.dart';
import 'package:tasq/utils/app_colors.dart';
import 'package:tasq/utils/app_strings.dart';
import 'package:tasq/utils/fonts.gen.dart';

import '../add_or_edit_task/add_task_screen.dart';

class TaskDetailsScreen extends StatefulWidget {
  // final TaskModel task;
  final String taskId;
  final bool isPersonal;
  const TaskDetailsScreen({
    super.key,
    required this.isPersonal,
    required this.taskId,
  });

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
    taskDetailController.getTaskDetails(
      context: context,
      isPersonal: widget.isPersonal,
      id: widget.taskId,
    );
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
          taskDetailController.task.value.title ?? "Task Details",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.poppins,
          ),
        ),
        actions: [
          taskDetailController.isManager.value || widget.isPersonal
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
                          task: taskDetailController.task.value,
                        ),
                      ),
                    ).then((value) async {
                      await taskDetailController.getTaskDetails(
                        context: context,
                        isPersonal: widget.isPersonal,
                        id: widget.taskId,
                      );
                    });
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
          child: Obx(
            () => taskDetailController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
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
                                "${taskDetailController.task.value.start!.day}/${taskDetailController.task.value.start!.month}/${taskDetailController.task.value.start!.year}",
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
                                "${taskDetailController.task.value.end!.day}/${taskDetailController.task.value.end!.month}/${taskDetailController.task.value.end!.year}",
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
                        taskDetailController.task.value.description ??
                            "No Description",
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
                            taskDetailController.task.value.status ??
                                "No Status",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.poppins,
                            ),
                          ),

                          /// Action button
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   child: Text(
                          //     taskDetailController.getActionButtonText(
                          //       isPersonal:
                          //           taskDetailController.task.value.isPersonal!,
                          //     ),
                          //     style: const TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 13,
                          //       fontWeight: FontWeight.w400,
                          //       fontFamily: FontFamily.poppins,
                          //     ),
                          //   ),
                          // ),
                          TaskStatusActionButton(
                            isManager: taskDetailController.isManager.value,
                            status: taskDetailController.task.value.status!,
                            isPersonal:
                                taskDetailController.task.value.isPersonal!,
                            taskDetailController: taskDetailController,
                            email: taskDetailController.task.value.email!,
                          ),
                        ],
                      ),

                      const Divider(height: 30),

                      widget.isPersonal
                          ? const SizedBox()
                          : GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                taskDetailController.onRemarksTap(
                                  context: context,
                                  taskId: widget.taskId,
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        taskId: widget.taskId,
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
      ),
    );
  }
}

class TaskStatusActionButton extends StatefulWidget {
  final String status;
  final bool isManager;
  final bool isPersonal;
  final TaskDetailController taskDetailController;
  final String email;

  const TaskStatusActionButton({
    super.key,
    required this.status,
    required this.isManager,
    required this.isPersonal,
    required this.taskDetailController,
    required this.email,
  });

  @override
  State<TaskStatusActionButton> createState() => _TaskStatusActionButtonState();
}

class _TaskStatusActionButtonState extends State<TaskStatusActionButton> {
  String getActionButtonText() {
    if (widget.isPersonal) {
      if (widget.status == "New") {
        return "Start";
      } else if (widget.status == "In Progress") {
        return "Complete";
      } else {
        return "";
      }
    } else {
      /// if the logged in user is not manager then action button will change accordingly
      if (!widget.isManager) {
        /// task will be by default assigned to user
        if (widget.status == "Assigned") {
          /// once it is assigned, user can start it
          return "Start";

          /// once user starts it will be in progress
          /// and it will show submit button
        } else if (widget.status == "In Progress") {
          return "Submit";
        } else if (widget.status == "Submitted") {
          return "";
        } else if (widget.status == "Under review") {
          /// once manager approves the task it will show completed in the status
          return "";
        } else {
          return "";
        }
      }

      /// this is for manager side action button
      else {
        if (widget.status == "Assigned") {
          /// once it is assigned, user can start it
          return "";

          /// once user starts it will be in progress
          /// and it will show submit button
        } else if (widget.status == "In Progress") {
          return "";
        }

        /// once user submits the task. it will show submitted in the status
        /// and it will show review button in the action button in manager side
        else if (widget.status == "Submitted") {
          return "Review";
        }

        /// once manager reviews the task it will show under review in the status
        /// and it will show approve button in the action button in manager side
        else if (widget.status == "Under review") {
          /// once manager approves the task it will show completed in the status
          return "Approve";
        } else if (widget.status == "Approved") {
          return "Complete";
        } else {
          return "";
        }
      }
    }
  }

  getSendingStatus() {
    if (widget.isPersonal) {
      if (taskStatusActionButtonText == "Start") {
        return "In Progress";
      } else if (taskStatusActionButtonText == "Complete") {
        return "Completed";
      }
    } else {
      /// if the logged in user is not manager then action button will change accordingly
      if (!widget.isManager) {
        /// task will be by default assigned to user
        if (taskStatusActionButtonText == "Start") {
          /// once it is assigned, user can start it
          return "In Progress";

          /// once user starts it will be in progress
          /// and it will show submit button
        } else if (taskStatusActionButtonText == "Submit") {
          return "Submitted";
        } else if (taskStatusActionButtonText == "Submitted") {
          return "";
        } else if (taskStatusActionButtonText == "Approve") {
          return "Approved";
        } else if (taskStatusActionButtonText == "Complete") {
          return "Completed";
        } else {
          return "";
        }
      }

      /// this is for manager side action button
      else {
        if (taskStatusActionButtonText == "Review") {
          return "Under review";
        } else if (taskStatusActionButtonText == "Approve") {
          return "Approved";
        } else if (taskStatusActionButtonText == "Complete") {
          return "Completed";
        } else {
          return "";
        }
      }
    }
  }

  String taskStatusActionButtonText = "";

  @override
  void initState() {
    super.initState();

    taskStatusActionButtonText = getActionButtonText();
  }

  @override
  Widget build(BuildContext context) {
    return taskStatusActionButtonText.isEmpty
        ? const SizedBox()
        : ElevatedButton(
            onPressed: () {
              widget.taskDetailController.onActionButtonTap(
                context: context,
                isPersonal: widget.isPersonal,
                status: getSendingStatus(),
                email: widget.email,
              );
            },
            child: Text(
              taskStatusActionButtonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.poppins,
              ),
            ),
          );
  }
}
