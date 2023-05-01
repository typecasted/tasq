import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// controller
import 'package:tasq/utils/app_colors.dart';

/// utils import
import '../../../utils/app_strings.dart';
import '../../../utils/fonts.gen.dart';
import '../../task/add_or_edit_task/add_task_screen.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddOrEditTaskScreen(
                  isEdit: false,
                );
              },
            ),
          ).then((value) {
            assigneeController.getTasksData(
              context: context,
            );
          });
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
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
                      /// Day, Date and Notification icon

                      /// Greeting Message
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
                                    itemCount: assigneeController.taskList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        behavior: HitTestBehavior.translucent,
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
                                              assigneeController.isLoading.value =
                                                  true;

                                              await assigneeController.getTasksData(
                                                context: context,
                                              );
                                              assigneeController.isLoading.value =
                                                  false;
                                            },
                                          );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.01,
                                            // horizontal: Get.width * 0.02,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // gradient: LinearGradient(
                                              //   colors: [
                                              //     AppColors.primaryColor,
                                              //     AppColors.primaryColorLight,
                                              //   ],
                                              //   begin: Alignment.topLeft,
                                              //   end: Alignment.bottomRight,
                                              // ),

                                              color: AppColors.primaryColorLight
                                                  .withOpacity(0.5),

                                              border: Border.all(
                                                color: AppColors.primaryColor,
                                                width: 1,
                                              ),
                                            ),
                                            height: Get.height * 0.18,
                                            width: Get.width * 0.35,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.04,
                                                vertical: Get.height * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      assigneeController
                                                              .taskList[index]
                                                              .title ??
                                                          "",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            FontFamily.poppins,
                                                        fontSize:
                                                            Get.height * 0.019,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),

                                                    /// Task Status

                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: Get
                                                                      .width *
                                                                  0.02,
                                                              vertical:
                                                                  Get.height *
                                                                      0.005),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                      child: Text(
                                                        assigneeController
                                                                .taskList[index]
                                                                .status ??
                                                            "Task Status",
                                                        style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .poppins,
                                                          fontSize: Get.height *
                                                              0.015,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  assigneeController.taskList[index]
                                                          .description ??
                                                      "",
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.poppins,
                                                    fontSize:
                                                        Get.height * 0.015,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
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
