import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/modules/task/models/task_model.dart';
import 'package:tasq/utils/local_storage.dart';
import 'package:tasq/utils/network_services/repository.dart';

import '../../remarks/remarks_screen.dart';

class TaskDetailController extends GetxController {
  RxBool isManager = false.obs;
  Rx<TaskModel> task = TaskModel().obs;

  RxBool isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isManager.value = await LocalStorage.getIsLoggedInAsManager();
  }

  getTaskDetails(
      {required BuildContext context,
      required bool isPersonal,
      required String id}) async {
    isLoading.value = true;
    try {
      task.value = await Repository.getTask(
        email: "",
        isPersonal: isPersonal,
        context: context,
        id: id,
      );
    } catch (e, s) {
      log("getTaskDetails - error: $e \n stack: $s");
    }
    isLoading.value = false;
  }

  void onRemarksTap({
    required BuildContext context,
    required String taskId,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RemarkScreen(
            taskId: taskId,
          );
        },
      ),
    );
  }

  Future<void> onActionButtonTap(
      {required BuildContext context,
      required bool isPersonal,
      required String status,
      required String email}) async {
    showFullScreenLoader(context: context);

    if (context.mounted) {}
    final isEdited = await Repository.editTask(
      context: context,
      isPersonal: isPersonal,
      status: status,
      id: task.value.id,
      description: task.value.description ?? "",
      title: task.value.title ?? "",
      email: email,
      end: task.value.end?.toIso8601String() ?? "",
      isCompleted: task.value.isCompleted ?? false,
      start: task.value.start?.toIso8601String() ?? "",
      taskId: task.value.id ?? "",
      // taskModel: task.value,
    );

    if (context.mounted && isEdited) {
      hideFullScreenLoader(context: context);

      // await getTaskDetails(
      //   context: context,
      //   isPersonal: isPersonal,
      //   id: task.value.id ?? "",
      // );

      isLoading.value = true;
      try {
        final response = await Repository.getTask(
          email: "",
          isPersonal: isPersonal,
          context: context,
          id: task.value.id ?? "",
        );

        if (response != null) {
          task.value = response;
        }
      } catch (e, s) {
        log("getTaskDetails - error: $e \n stack: $s");
      }
      isLoading.value = false;
    }
  }
}


/// assigned - from manager side by default
/// in progress - will be changed from user side
/// submitted - will be changed from user side
/// completed - will be changed from manager side
/// approved - will be changed from manager side
/// running late - optional 
/// under review - will be changed from manager side