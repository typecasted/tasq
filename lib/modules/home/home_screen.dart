/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// controller
import 'package:tasq/modules/home/home_controller.dart';

/// utils import
import '../../utils/app_strings.dart';
import '../../utils/fonts.gen.dart';
import '../../utils/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
                        AppStrings.myPriorityTasks,
                        style: TextStyle(
                          fontFamily: FontFamily.poppins,
                          fontSize: Get.height * 0.02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      /// Priority Tasks slider
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeController.priorityTasks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.01,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  homeController.priorityTasks[index].title,
                                  style: TextStyle(
                                    fontFamily: FontFamily.poppins,
                                    fontSize: Get.height * 0.018,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  homeController.priorityTasks[index].description,
                                  style: TextStyle(
                                    fontFamily: FontFamily.poppins,
                                    fontSize: Get.height * 0.015,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
