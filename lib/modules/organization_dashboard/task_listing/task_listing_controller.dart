import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/utils/local_storage.dart';
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

  Future<void> deleteUser(
      {required BuildContext context, required String userEmail}) async {
    showFullScreenLoader(context: context);
    await Repository.deleteUser(
      context: context,
      email: (await LocalStorage.getUserData())!.body!.model!.email ?? "",
      userEmail: userEmail,
    );

    hideFullScreenLoader(context: context);

    final userData = await LocalStorage.getUserData();

    userData!.body!.model!.users!.removeWhere(
      (element) => element.email == userEmail,
    );

    await LocalStorage.saveUserData(
      data: userData,
    );

    Navigator.pop(context);
  }
}
