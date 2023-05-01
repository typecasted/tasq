import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/utils/network_services/repository.dart';

import '../../task/models/task_model.dart';

class TaskListingController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<TaskModel> taskList = <TaskModel>[].obs;

  void initTaskListingScreenList({
    required BuildContext context,
    required String email,
  }) async {
    isLoading.value = true;

    taskList.value = await Repository.getTask(
        email: email, isPersonal: false, context: context);

    isLoading.value = false;
  }
}
