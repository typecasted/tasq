import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/full_screen_loader.dart';
import 'package:tasq/utils/local_storage.dart';
import 'package:tasq/utils/network_services/repository.dart';

import '../../models/remarks_list.dart';
import '../../models/user_model.dart';

class RemarksController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<RemarksModel> remarks = <RemarksModel>[].obs;

  UserModel userData = UserModel();

  TextEditingController remarksTextController = TextEditingController();

  getRemarks({
    required String taskId,
    required BuildContext context,
  }) async {
    isLoading.value = true;

    userData = (await LocalStorage.getUserData())!;

    remarks.value = await Repository.getRemarks(
      taskId: taskId,
      context: context,
    );
    isLoading.value = false;
  }

  Future<void> addRemarks({
    required String taskId,
    required BuildContext context,
  }) async {
    showFullScreenLoader(context: context);

    await Repository.addRemarks(
      taskId: taskId,
      context: context,
      message: remarksTextController.text,
      email: (await LocalStorage.getUserData())!.body!.model!.email ?? "",
      dateTime: DateTime.now().toIso8601String(),
    );

    remarksTextController.clear();

    await getRemarks(
      taskId: taskId,
      context: context,
    );

    hideFullScreenLoader(context: context);
  }
}
