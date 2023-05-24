import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/modules/task/models/task_model.dart';

import '../../common_widgets/task_details_tile.dart';
import '../../utils/app_colors.dart';
import '../task/task_details/task_details_screen.dart';

class StatisticsTaskListingScreen extends StatefulWidget {
  final String status;
  final List<TaskModel>? taskList;
  const StatisticsTaskListingScreen({
    super.key,
    required this.status,
    this.taskList,
  });

  @override
  State<StatisticsTaskListingScreen> createState() =>
      _StatisticsTaskListingScreenState();
}

class _StatisticsTaskListingScreenState
    extends State<StatisticsTaskListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.status,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),

        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: AppColors.primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: widget.taskList?.isEmpty ?? true
          ? SizedBox(
              height: Get.height * 0.8,
              child: Center(
                child: Text(
                  "No tasks assigned",
                  style: TextStyle(
                    fontSize: Get.height * 0.024,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04,
              vertical: Get.height * 0.02,
              
            ),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.taskList?.length,
                itemBuilder: (context, index) {
                  return TaskDetailsTile(
                    taskDetails: widget.taskList?[index] ?? TaskModel(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TaskDetailsScreen(
                              isPersonal: false,
                              taskId: widget.taskList?[index].id ?? "",
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
          ),
    );
  }
}
