import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Rx<TaskCategory> selectedCategory = TaskCategory.daily.obs;

  List<String> assigneeList = [
    "Select Assignee",
    "Assignee 1",
    "Assignee 2",
    "Assignee 3",
    "Assignee 4",
    "Assignee 5",
  ];

  RxString selectedAssignee = "Select Assignee".obs;

}

enum TaskCategory {
  daily,
  priority,
}
