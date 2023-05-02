import 'dart:developer';

import 'package:get/get.dart';
import 'package:tasq/models/user_model.dart';
import 'package:tasq/utils/local_storage.dart';

class ManagerController extends GetxController {
  /// - [userData] is used to store the user (manager's) data
  /// - it can be used later to get the list of assignees working under the manager
  /// - it is of type [UserModel]
  UserModel userData = UserModel();

  /// - [assigneeList] is used to store the list of assignees working under the manager
  /// - it is of type [RxList<User>]
  RxList<User> assigneeList = <User>[].obs;

  RxBool isLoading = false.obs;

  /// - [getManagerInfo] method is used to get the manager's info and list of assignees working under the manager
  Future<void> getManagerInfo() async {
    log("getManagerInfo called");
    isLoading.value = true;

    if (assigneeList.isNotEmpty) {
      assigneeList.clear();
    }

    userData = (await LocalStorage.getUserData())!;

    userData.body?.model?.users?.forEach(
      (element) {
        if ((element.email?.isNotEmpty ?? false)) {
          assigneeList.add(element);
        }
      },
    );

    isLoading.value = false;
  }
}
