/// package imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/task_details_tile.dart';

/// controller
import 'package:tasq/modules/home/home_controller.dart';
import 'package:tasq/utils/app_colors.dart';

/// utils import
import '../../utils/app_strings.dart';
import '../../utils/fonts.gen.dart';
import '../../utils/local_storage.dart';
import '../task/add_or_edit_task/add_task_screen.dart';
import '../task/task_details/task_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    homeController.initHomeScreenList(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isManager = await LocalStorage.getIsLoggedInAsManager();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddOrEditTaskScreen(
                  isEdit: false,
                  isNormal: isManager,
                );
              },
            ),
          ).then((value) {
            homeController.getTasksData(
              isPersonal: true,
              context: context,
            );
          });
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Obx(
          () => homeController.isLoading.value
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            homeController.dateTimeString.value,
                            style: TextStyle(
                              fontFamily: FontFamily.poppins,
                              fontSize: Get.height * 0.018,
                              // color: Colors.black,
                            ),
                          ),
                          // SvgPicture.asset(
                          //   Assets.svgs.icNotificationBellFilled,
                          // )
                        ],
                      ),

                      /// Greeting Message
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.03,
                        ),
                        child: Text(
                          homeController.greetingMessage.value,
                          style: TextStyle(
                            fontFamily: FontFamily.poppins,
                            fontSize: Get.height * 0.025,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      /// My Priority Tasks
                      Text(
                        AppStrings.myTasks,
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
                            homeController.isLoading.value = true;

                            homeController.getTasksData(
                              isPersonal: true,
                              context: context,
                            );
                            homeController.isLoading.value = false;
                          },
                          child: Obx(
                            () => homeController.taskList.isEmpty
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
                                    itemCount: homeController.taskList.length,
                                    itemBuilder: (context, index) {
                                      return TaskDetailsTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return TaskDetailsScreen(
                                                  taskId: homeController
                                                          .taskList[index].id ??
                                                      "",
                                                  isPersonal: homeController
                                                          .taskList[index]
                                                          .isPersonal ??
                                                      false,
                                                );
                                              },
                                            ),
                                          ).then(
                                            (value) async {
                                              homeController.isLoading.value =
                                                  true;

                                              await homeController.getTasksData(
                                                isPersonal: true,
                                                context: context,
                                              );
                                              homeController.isLoading.value =
                                                  false;
                                            },
                                          );
                                        },
                                        taskDetails:
                                            homeController.taskList[index],
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
