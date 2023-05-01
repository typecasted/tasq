import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/modules/task/models/task_model.dart';
import 'package:tasq/utils/local_storage.dart';
import 'package:tasq/utils/network_services/repository.dart';

import '../../../utils/app_colors.dart';
import 'add_task_screen.dart';

class AddTaskController extends GetxController {
  /// - [titleController] is used to store the title of the task.
  TextEditingController titleController = TextEditingController();

  /// - [descriptionController] is used to store the description of the task.
  TextEditingController descriptionController = TextEditingController();

  /// - [startDate] is used to store the start date of the task.
  Rx<DateTime> startDate = DateTime.now().obs;

  /// - [endDate] is used to store the end date of the task.
  Rx<DateTime> endDate = DateTime.now().obs;

  /// - [isManager] is used to check if the user is manager or not.
  /// - if the user is manager then he can assign the task to other users.
  /// - if this is true then the assignee dropdown button will be visible.
  RxBool isManager = false.obs;

  /// - [assigneeList] will store the list of emails of the assignees a manager can assign the task to.
  RxList<String> assigneeList = [
    "Select Assignee",
  ].obs;

  /// - [selectedAssignee] will store the selected assignee from the list of assignees.
  /// - it is used in dropdown button to show the selected assignee.
  RxString selectedAssignee = "Select Assignee".obs;

  /// - [onInitStateCalled] is used to initiate all the controllers and variables of the screen.
  /// - [widget] is of [AddOrEditTaskScreen] and used to get the data from the screen.
  Future<void> onInitStateCalled({required AddOrEditTaskScreen widget}) async {
    titleController = TextEditingController();
    descriptionController = TextEditingController();

    if (widget.isEdit) {
      titleController.text = widget.task?.title ?? "";
      descriptionController.text = widget.task?.description ?? "";
    } else {
      titleController.text = '';
      descriptionController.text = '';
    }

    /// check if the user is manager or not.
    isManager.value = await LocalStorage.getIsLoggedInAsManager();

    /// if the user is manager then get the list of assignees.

    if (isManager.value) {
      assigneeList.clear();
      assigneeList.add("Select Assignee");

      final userData = await LocalStorage.getUserData();
      userData?.body?.model?.users?.forEach(
        (element) {
          if (element.email != null &&
              element.email != "" &&
              !assigneeList.contains(element.email!)) {
            assigneeList.add(element.email!);
          }
        },
      );
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  /// - [selectDate] is used to show the date picker to select the date.
  /// - [context] is of [BuildContext] and used to show the snackbar.
  /// - [isStartDate] is of [bool] and used to check if the date is start date or end date.
  void selectDate({required BuildContext context, required bool isStartDate}) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    ).then(
      (value) {
        if (value != null) {
          if (isStartDate) {
            startDate.value = value;
          } else {
            /// - [endDate] should be equal or greater than [startDate].

            if (value.isAfter(startDate.value) ||
                value.isAtSameMomentAs(startDate.value)) {
              endDate.value = value;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    "End date should be greater than start date",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
              );
            }
          }
        }
      },
    );
  }

  Future<void> createOrEditTask({
    required bool isEdit,
    required TaskModel? task,
    required BuildContext context,

    /// this field is used when a manager wants to create a task for themselves.
    bool isNormalTask = true,
  }) async {
    if (validateFields(
      context: context,
      isNormal: isNormalTask,
    )) {
      showFullScreenLoader(context: context);

      final userData = await LocalStorage.getUserData();
      if (!isEdit && context.mounted) {
        bool isAdded = await Repository.addTask(
          title: titleController.text,
          description: descriptionController.text,
          start: startDate.value.toIso8601String(),
          end: endDate.value.toIso8601String(),
          email: isManager.value && !isNormalTask
              ? selectedAssignee.value
              : userData?.body?.model?.email ?? "",
          isPersonal: !isManager.value || isNormalTask,
          context: context,
        );

        if (isAdded && context.mounted) {
          Navigator.pop(context);
        }
      } else {
        bool isEdited = await Repository.editTask(
          title: titleController.text,
          description: descriptionController.text,
          start: startDate.value.toIso8601String(),
          end: endDate.value.toIso8601String(),
          email: isManager.value
              ? selectedAssignee.value
              : userData?.body?.model?.email ?? "",
          isPersonal: !isManager.value,
          context: context,
          taskId: task?.id ?? "",
          isCompleted: task?.isCompleted ?? false,
          status: task?.status ?? "",
        );

        if (isEdited && context.mounted) {
          Navigator.pop(context);
        }
      }
      if (context.mounted) {
        hideFullScreenLoader(context: context);
      }
    }
  }

  bool validateFields({required BuildContext context, required bool isNormal}) {
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Please enter title",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Please enter description",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );

      return false;
    } else if (!(endDate.value.isAfter(startDate.value) ||
        endDate.value.isAtSameMomentAs(startDate.value))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "End date should be greater than start date",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else if (isManager.value &&
        !isNormal &&
        selectedAssignee.value == "Select Assignee") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Please select assignee",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}
