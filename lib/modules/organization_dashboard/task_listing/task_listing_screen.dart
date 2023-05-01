import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/task_details_tile.dart';
import 'package:tasq/models/user_model.dart';
import 'package:tasq/modules/organization_dashboard/task_listing/task_listing_controller.dart';
import 'package:tasq/modules/task/task_details/task_details_screen.dart';
import 'package:tasq/utils/app_colors.dart';

import '../../task/add_or_edit_task/add_task_screen.dart';

class TaskListingScreen extends StatefulWidget {
  final User assignee;
  const TaskListingScreen({super.key, required this.assignee});

  @override
  State<TaskListingScreen> createState() => _TaskListingScreenState();
}

class _TaskListingScreenState extends State<TaskListingScreen> {
  late TaskListingController taskListingController;

  @override
  void initState() {
    super.initState();
    taskListingController = Get.put(TaskListingController());
    taskListingController.initTaskListingScreenList(
      context: context,
      email: widget.assignee.email ?? "",
    );
  }

  @override
  void dispose() {
    taskListingController.taskList.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: AppColors.primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.assignee.email ?? "",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddOrEditTaskScreen(
                  email: widget.assignee.email ?? "",
                  isEdit: false,
                );
              },
            ),
          ).then((value) {
            taskListingController.initTaskListingScreenList(
              context: context,
              email: widget.assignee.email ?? "",
            );
          });
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.02,
          horizontal: Get.width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Obx(
              () => taskListingController.isLoading.value
                  ? SizedBox(
                      height: Get.height * 0.8,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : taskListingController.taskList.isEmpty
                      ? SizedBox(
                          height: Get.height * 0.8,
                          child: Center(
                            child: Text(
                              "No tasks assigned",
                              style: TextStyle(
                                fontSize: Get.height * 0.024,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: taskListingController.taskList.length,
                          itemBuilder: (context, index) {
                            return TaskDetailsTile(
                              taskDetails:
                                  taskListingController.taskList[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TaskDetailsScreen(
                                        isPersonal: false,
                                        taskId: taskListingController
                                                .taskList[index].id ??
                                            "",
                                      );
                                    },
                                  ),
                                ).then(
                                  (value) {
                                    taskListingController
                                        .initTaskListingScreenList(
                                      context: context,
                                      email: widget.assignee.email ?? "",
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
