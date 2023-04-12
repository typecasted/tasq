/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// controller
import 'package:tasq/modules/home/home_controller.dart';
import 'package:tasq/utils/app_colors.dart';

/// utils import
import '../../utils/app_strings.dart';
import '../../utils/fonts.gen.dart';
import '../../utils/assets.gen.dart';
import '../task/add_task_screen.dart';
import '../task/models/task_model.dart';

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
    homeController.initHomeScreenList();
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
          );
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
              : SingleChildScrollView(
                  child: Padding(
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
                            SvgPicture.asset(
                              Assets.svgs.icNotificationBellFilled,
                            )
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
                          AppStrings.myPriorityTasks,
                          style: TextStyle(
                            fontFamily: FontFamily.poppins,
                            fontSize: Get.height * 0.02,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        /// Priority Tasks slider
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Get.height * 0.01),
                          child: SizedBox(
                            width: Get.width,
                            height: Get.height * 0.2,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: homeController.priorityTasks.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.01,
                                    horizontal: Get.width * 0.02,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryColor,
                                          AppColors.primaryColorLight,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    height: Get.height * 0.2,
                                    width: Get.width * 0.35,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.02,
                                        vertical: Get.height * 0.01),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          homeController
                                              .priorityTasks[index].title,
                                          style: TextStyle(
                                            fontFamily: FontFamily.poppins,
                                            fontSize: Get.height * 0.018,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          homeController
                                              .priorityTasks[index].description,
                                          style: TextStyle(
                                            fontFamily: FontFamily.poppins,
                                            fontSize: Get.height * 0.015,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        /// Daily Tasks
                        Text(
                          AppStrings.dailyTasks,
                          style: TextStyle(
                            fontFamily: FontFamily.poppins,
                            fontSize: Get.height * 0.02,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        /// Daily Tasks List
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.01,
                          ),
                          child: GetBuilder<HomeController>(
                            init: homeController,
                            id: "dailyTasks",
                            builder: (controller) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: homeController.dailyTasks.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      homeController
                                              .dailyTasks[index].isCompleted =
                                          !homeController
                                              .dailyTasks[index].isCompleted;
                                      homeController.update(["dailyTasks"]);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: Get.height * 0.01,
                                        horizontal: Get.width * 0.02,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            homeController
                                                .dailyTasks[index].title,
                                            style: TextStyle(
                                              fontFamily: FontFamily.poppins,
                                              fontSize: Get.height * 0.018,
                                              fontWeight: FontWeight.w600,
                                              color: homeController
                                                      .dailyTasks[index]
                                                      .isCompleted
                                                  ? AppColors.primaryColor
                                                  : Colors.black,
                                            ),
                                          ),
                                          Obx(
                                            () => Checkbox(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              value: homeController
                                                  .dailyTasks[index]
                                                  .isCompleted,
                                              onChanged: (value) {
                                                homeController.dailyTasks[index]
                                                    .isCompleted = value!;
                                                homeController
                                                    .update(["dailyTasks"]);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
