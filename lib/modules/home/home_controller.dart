/// packages import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/utils/local_storage.dart';
import 'package:tasq/utils/network_services/repository.dart';

import '../task/models/task_model.dart';

class HomeController extends GetxController {
  /// - [isLoading] is used for showing and hiding and loader at the time of screen initialization.
  final RxBool isLoading = false.obs;

  /// - [dateTimeString] variable is used to show day and date at the top left side.
  final RxString dateTimeString = ''.obs;

  /// - [greetingMessage] is used to show greetings message.
  final RxString greetingMessage = "".obs;

  /// - [initHomeScreenList] this function will be call in [initState] method of [Home] widget.
  void initHomeScreenList({
    required BuildContext context,
  }) async {
    isLoading.value = true;

    /// here i've put a delay to replicate api call.
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    getDayAndDateValues();

    await getGreetingsMessage();

    if (context.mounted) {
      await getTasksData(
        context: context,
        isPersonal: true,
      );
    }
    isLoading.value = false;
  }

  /// - [getDayAndDateValues] function is used to get the current Day and Date.
  void getDayAndDateValues() {
    String weekDay = "";
    String month = "";

    switch (DateTime.now().weekday) {
      case DateTime.monday:
        weekDay = "Monday";
        break;
      case DateTime.tuesday:
        weekDay = "Tuesday";
        break;
      case DateTime.wednesday:
        weekDay = "Wednesday";
        break;
      case DateTime.thursday:
        weekDay = "Thursday";
        break;
      case DateTime.friday:
        weekDay = "Friday";
        break;
      case DateTime.saturday:
        weekDay = "Saturday";
        break;
      case DateTime.sunday:
        weekDay = "Sunday";
        break;
      default:
    }

    switch (DateTime.now().month) {
      case DateTime.january:
        month = 'Jan.';
        break;
      case DateTime.february:
        month = 'Feb.';
        break;
      case DateTime.march:
        month = 'Mar.';
        break;
      case DateTime.april:
        month = 'Apr.';
        break;
      case DateTime.may:
        month = 'May';
        break;
      case DateTime.june:
        month = 'Jun.';
        break;
      case DateTime.july:
        month = 'Jul.';
        break;
      case DateTime.august:
        month = 'Aug.';
        break;
      case DateTime.september:
        month = 'Sept.';
        break;
      case DateTime.october:
        month = 'Oct.';
        break;
      case DateTime.november:
        month = 'Nov.';
        break;
      case DateTime.december:
        month = 'Dec.';
        break;
      default:
        month = 'Err';
        break;
    }

    dateTimeString.value =
        '$weekDay, $month ${DateTime.now().day} ${DateTime.now().year}';
  }

  /// [isTaskLoading] is used for showing and hiding and loader at the time of screen initialization.
  RxBool isTaskLoading = false.obs;

  /// [getGreetingsMessage] get greetings message for user.
  /// todo : randomize the greeting message.
  Future<void> getGreetingsMessage() async {
    final userData = await LocalStorage.getUserData();

    greetingMessage.value =
        "Welcome ${userData?.body?.model?.firstName ?? ""}!!!";
  }

  /// - [taskList] is used to show the list of tasks.
  RxList<TaskModel> taskList = <TaskModel>[].obs;

  getTasksData({
    required BuildContext context,
    required bool isPersonal,
  }) async {
    isTaskLoading.value = true;
    taskList.clear();

    final userData = await LocalStorage.getUserData();
    // final bool isPersonal = !(await LocalStorage.getIsLoggedInAsManager());

    if (context.mounted) {
      taskList.value = (await Repository.getTask(
        context: context,
        email: userData?.body?.model?.email ?? "",
        isPersonal: isPersonal,
      ))!;
    }

    isTaskLoading.value = false;
  }
}

HomeController get homeController => Get.put(HomeController());
