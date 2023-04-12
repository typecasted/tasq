import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Rx<TaskCategory> selectedCategory = TaskCategory.daily.obs;

}

enum TaskCategory {
  daily,
  priority,
}
