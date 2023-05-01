import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/task_details_tile.dart';

/// utils import
import '../../../utils/app_strings.dart';
import '../../../utils/fonts.gen.dart';
import '../../task/task_details/task_details_screen.dart';
import 'assignee_controller.dart';

class AssigneeScreen extends StatefulWidget {
  const AssigneeScreen({super.key});

  @override
  State<AssigneeScreen> createState() => _AssigneeScreenState();
}

class _AssigneeScreenState extends State<AssigneeScreen> {
  late AssigneeController assigneeController;

  @override
  void initState() {
    super.initState();
    assigneeController = Get.put(AssigneeController());
    assigneeController.initOrgDashboardScreenList(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => assigneeController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.02,
                    horizontal: Get.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.03,
                        ),
                        child: Text(
                          "Organization Dashboard",
                          style: TextStyle(
                            fontFamily: FontFamily.poppins,
                            fontSize: Get.height * 0.025,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      /// My Priority Tasks
                      Text(
                        AppStrings.yourTasks,
                        style: TextStyle(
                          fontFamily: FontFamily.poppins,
                          fontSize: Get.height * 0.02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(
                        height: Get.height * 0.02,
                      ),

                      /// Priority Tasks slider
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            assigneeController.isLoading.value = true;

                            assigneeController.getTasksData(
                              context: context,
                            );
                            assigneeController.isLoading.value = false;
                          },
                          child: Obx(
                            () => assigneeController.taskList.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Tasks Found",
                                      style: TextStyle(
                                        fontFamily: FontFamily.poppins,
                                        fontSize: Get.height * 0.02,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount:
                                        assigneeController.taskList.length,
                                    itemBuilder: (context, index) {
                                      return TaskDetailsTile(
                                        taskDetails:
                                            assigneeController.taskList[index],
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return TaskDetailsScreen(
                                                  taskId: assigneeController
                                                          .taskList[index].id ??
                                                      "",
                                                  isPersonal: assigneeController
                                                          .taskList[index]
                                                          .isPersonal ??
                                                      false,
                                                );
                                              },
                                            ),
                                          ).then(
                                            (value) async {
                                              assigneeController
                                                  .isLoading.value = true;

                                              await assigneeController
                                                  .getTasksData(
                                                context: context,
                                              );
                                              assigneeController
                                                  .isLoading.value = false;
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
