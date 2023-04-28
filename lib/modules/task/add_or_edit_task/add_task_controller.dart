import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  /// - [assigneeList] will store the list of emails of the assignees a manager can assign the task to.
  List<String> assigneeList = [
    "Select Assignee",
    "Assignee 1",
    "Assignee 2",
    "Assignee 3",
    "Assignee 4",
    "Assignee 5",
  ];

  /// - [selectedAssignee] will store the selected assignee from the list of assignees.
  /// - it is used in dropdown button to show the selected assignee.
  RxString selectedAssignee = "Select Assignee".obs;

  /// - [onInitStateCalled] is used to initiate all the controllers and variables of the screen.
  /// - [widget] is of [AddOrEditTaskScreen] and used to get the data from the screen.
  void onInitStateCalled({required AddOrEditTaskScreen widget}) {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    if (widget.isEdit) {
      titleController.text = widget.task?.title ?? "";
      descriptionController.text = widget.task?.description ?? "";
    } else {
      titleController.text = '';
      descriptionController.text = '';
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
}
