import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/modules/task/models/task_model.dart';

import '../../utils/local_storage.dart';
import '../../utils/network_services/repository.dart';
import 'statistics_tasks_listing_screen.dart';

class StatisticsController extends GetxController {
  List<TaskModel>? taskList = [];

  RxBool isLoading = true.obs;

  int totalTasks = 0;

  int completedTasks = 0;

  int pendingTasks = 0;

  int inProgressTasks = 0;

  int underReviewTasks = 0;

  int approvedTasks = 0;

  int newTasks = 0;

  int submittedTasks = 0;

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

  void getStatistics({required BuildContext context}) async {
    isLoading.value = true;

    // reset the values
    totalTasks = 0;
    completedTasks = 0;
    pendingTasks = 0;
    inProgressTasks = 0;
    underReviewTasks = 0;
    approvedTasks = 0;
    newTasks = 0;
    submittedTasks = 0;

    final userData = await LocalStorage.getUserData();

    taskList = await Repository.getStatistics(
      userEmail: userData?.body?.model?.email ?? "",
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

    isLoading.value = false;
  }

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

  // List<MonthStates> statisticsList = [
  //   MonthStates(month: 'Jan', states: 30),
  //   MonthStates(month: 'Feb', states: 70),
  //   MonthStates(month: 'Mar', states: 30),
  //   MonthStates(month: 'Apr', states: 50),
  //   MonthStates(month: 'May', states: 20),
  //   MonthStates(month: 'Jun', states: 80),
  //   MonthStates(month: 'Jul', states: 50),
  //   MonthStates(month: 'Aug', states: 80),
  //   MonthStates(month: 'Sep', states: 60),
  //   MonthStates(month: 'Oct', states: 50),
  //   MonthStates(month: 'Nov', states: 10),
  //   MonthStates(month: 'Dec', states: 40),
  // ];
}

class MonthStates {
  final String month;
  final int states;

  MonthStates({
    required this.month,
    required this.states,
  });
}
