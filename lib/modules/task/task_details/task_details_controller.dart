import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/utils/local_storage.dart';

import '../../remarks/remarks_screen.dart';

class TaskDetailController extends GetxController {
  RxBool isManager = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    isManager.value = await LocalStorage.getIsLoggedInAsManager();
  }

  void onRemarksTap({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const RemarkScreen();
        },
      ),
    );
  }
}
