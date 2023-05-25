import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/models/user_model.dart';
import 'package:tasq/modules/task/models/task_model.dart';

import '../../utils/local_storage.dart';
import '../../utils/network_services/repository.dart';
import 'statistics_tasks_listing_screen.dart';

class StatisticsController extends GetxController {
  List<TaskModel>? taskList = [];

  /// [isLoading] is used for showing and hiding and loader at the time of screen initialization.
  RxBool isLoading = true.obs;

  /// [isStatsLoading] is used for showing and hiding and loader at the time of getting statistics data.
  RxBool isStatsLoading = true.obs;

  /// [totalTasks] is used to show the total number of tasks.
  int totalTasks = 0;

  /// [completedTasks] is used to show the total number of completed tasks.
  int completedTasks = 0;

  /// [pendingTasks] is used to show the total number of pending tasks.
  int pendingTasks = 0;

  /// [inProgressTasks] is used to show the total number of in progress tasks.
  int inProgressTasks = 0;

  /// [underReviewTasks] is used to show the total number of under review tasks.
  int underReviewTasks = 0;

  /// [approvedTasks] is used to show the total number of approved tasks.
  int approvedTasks = 0;

  /// [newTasks] is used to show the total number of new tasks.
  int newTasks = 0;

  /// [submittedTasks] is used to show the total number of submitted tasks.
  int submittedTasks = 0;

  UserModel? _userData;

  /// [isManager] is used to check if the user is manager or not.
  RxBool isManager = false.obs;

  List<User> assigneeList = [];

  /// [statisticsMap] is used to show the statistics data in the grid view.
  RxMap<String, int> get statisticsMap => {
        "Total Tasks": totalTasks,
        "Completed": completedTasks,
        "New": newTasks,
        "Pending": pendingTasks,
        "Submitted": submittedTasks,
        "In Progress": inProgressTasks,
        "Under Review": underReviewTasks,
        "Approved": approvedTasks,
      }.obs;

  /// [configureStatisticsScreen] method is used to configure the statistics screen.
  /// it will be called in [initState] method of [StatisticsScreen] widget.
  /// it will set the initial values of the variables.
  /// it will also get the user data from the local storage.
  /// if the user is manager then it will get the list of the assignees.
  configureStatisticsScreen() async {
    isLoading.value = true;
    totalTasks = 0;
    completedTasks = 0;
    pendingTasks = 0;
    inProgressTasks = 0;
    underReviewTasks = 0;
    approvedTasks = 0;
    newTasks = 0;
    submittedTasks = 0;
    isLoading.value = false;

    _userData = await LocalStorage.getUserData();

    isManager.value = await LocalStorage.getIsLoggedInAsManager();

    if (isManager.value) {
      _userData?.body?.model?.users?.forEach(
        (element) {
          assigneeList.add(element);
        },
      );
    }

    isLoading.value = false;
  }

  /// [getStatistics] method will get the statistics data.
  /// if the user is manager then it will get the statistics data of the user using the [userEmail] parameter.
  /// if the user is not manager then it will get the statistics data of the logged in user's email.
  Future<void> getStatistics(
      {required BuildContext context, String? userEmail}) async {
    // isStatsLoading.value = true;
    taskList = await Repository.getStatistics(
      userEmail: isManager.value
          ? userEmail ?? ""
          : _userData?.body?.model?.email ?? "",
      context: context,
    );

    if (taskList != null) {
      totalTasks = taskList?.length ?? 0;
      for (TaskModel element in taskList ?? <TaskModel>[]) {
        if (element.status == "Assigned") {
          approvedTasks++;
        } else if (element.status == "In Progress") {
          inProgressTasks++;
        } else if (element.status == "Submitted") {
          submittedTasks++;
        } else if (element.status == "Under review") {
          underReviewTasks++;
        } else if (element.status == "Approved") {
          approvedTasks++;
        } else if (element.status == "Completed") {
          completedTasks++;
        } else if (element.status == "New") {
          newTasks++;
        }
      }
    }

    isStatsLoading.value = false;
  }

  /// [onStatisticsTileTap] method will be called when the user tap on the statistics tile.
  /// it will navigate the user to the [StatisticsTaskListingScreen] screen where all the tasks are listed.
  onStatisticsTileTap({required String status, required BuildContext context}) {
    /// get the list of the task with the given status
    switch (status) {
      case "Total Tasks":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return StatisticsTaskListingScreen(
                status: "Total Tasks",
                taskList: taskList,
              );
            },
          ),
        );
        break;
      case "Completed":
        getTasksByStatus(status: status, context: context);
        break;
      case "Pending":
        getTasksByStatus(status: status, context: context);
        break;
      case "In Progress":
        getTasksByStatus(status: status, context: context);
        break;
      case "Under Review":
        getTasksByStatus(status: status, context: context);
        break;
      case "Approved":
        getTasksByStatus(status: status, context: context);
        break;
      case "New":
        getTasksByStatus(status: status, context: context);
        break;
      case "Submitted":
        getTasksByStatus(status: status, context: context);
        break;
    }
  }

  /// [getTasksByStatus] method will get the list of the tasks with the given status.
  /// and pass the list to the [StatisticsTaskListingScreen] screen.
  void getTasksByStatus(
      {required String status, required BuildContext context}) {
    List<TaskModel> tempTaskList = [];

    for (TaskModel element in taskList ?? <TaskModel>[]) {
      if (element.status == status) {
        tempTaskList.add(element);
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return StatisticsTaskListingScreen(
            status: status,
            taskList: tempTaskList,
          );
        },
      ),
    );
  }
}
