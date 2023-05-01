/// packages import
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tasq/utils/local_storage.dart';
import 'package:tasq/utils/network_services/repository.dart';

import '../../task/models/task_model.dart';

class AssigneeController extends GetxController {
  /// - [isLoading] is used for showing and hiding and loader at the time of screen initialization.
  RxBool isLoading = false.obs;

  /// - [initOrgDashboardScreenList] this function will be call in [initState] method of [Home] widget.
  void initOrgDashboardScreenList({
    required BuildContext context,
  }) async {
    isLoading.value = true;

    /// here i've put a delay to replicate api call.
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    if (context.mounted) {
      await getTasksData(
        context: context,
      );
    }
    isLoading.value = false;
  }

  /// [isTaskLoading] is used for showing and hiding and loader at the time of screen initialization.
  RxBool isTaskLoading = false.obs;

  /// - [taskList] is used to show the list of tasks.
  RxList<TaskModel> taskList = <TaskModel>[].obs;

  getTasksData({
    required BuildContext context,
  }) async {
    isTaskLoading.value = true;
    taskList.clear();

    final userData = await LocalStorage.getUserData();
    // final bool isPersonal = !(await LocalStorage.getIsLoggedInAsManager());

    if (context.mounted) {
      taskList.value = (await Repository.getTask(
        context: context,
        email: userData?.body?.model?.email ?? "",
        isPersonal: false,
      ))!;
    }

    isTaskLoading.value = false;
  }
}
