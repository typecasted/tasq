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
                          onRefresh: () async {},
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
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: homeController.taskList.length,

                                    // scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return TaskDetailsScreen(
                                                  task: homeController
                                                      .taskList[index],
                                                );
                                              },
                                            ),
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
                                                      homeController
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
                                                        homeController
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
                                                  homeController.taskList[index]
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
