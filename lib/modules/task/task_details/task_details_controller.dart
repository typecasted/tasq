import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../remarks/remarks_screen.dart';

class TaskDetailController extends GetxController {
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
