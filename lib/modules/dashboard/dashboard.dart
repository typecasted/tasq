/// package imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// controllers
import './dashboard_controller.dart';

/// utils imports
import '../../utils/app_colors.dart';
import '../../utils/assets.gen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => dashboardController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : dashboardController.dashboardScreenList[
                  dashboardController.currentScreenIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => dashboardController.changeScreen(0),
                child: SvgPicture.asset(
                  Assets.svgs.icHomeFilled,
                  colorFilter: ColorFilter.mode(
                    dashboardController.currentScreenIndex.value == 0
                        ? AppColors.primaryColor
                        : AppColors.primaryColorLight,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => dashboardController.changeScreen(1),
                child: SvgPicture.asset(
                  Assets.svgs.icCalenderFilled,
                  colorFilter: ColorFilter.mode(
                    dashboardController.currentScreenIndex.value == 1
                        ? AppColors.primaryColor
                        : AppColors.primaryColorLight,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => dashboardController.changeScreen(2),
                child: SvgPicture.asset(
                  Assets.svgs.icPersonFilled,
                  colorFilter: ColorFilter.mode(
                    dashboardController.currentScreenIndex.value == 2
                        ? AppColors.primaryColor
                        : AppColors.primaryColorLight,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         Assets.svgs.icHomeFilled,
      //         colorFilter: ColorFilter.mode(
      //           dashboardController.currentScreenIndex.value == 0
      //               ? AppColors.primaryColor
      //               : AppColors.primaryColorLight,
      //           BlendMode.srcIn,
      //         ),
      //       ),
      //       label: "Home",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         Assets.svgs.icCalenderFilled,
      //         colorFilter: ColorFilter.mode(
      //           dashboardController.currentScreenIndex.value == 1
      //               ? AppColors.primaryColor
      //               : AppColors.primaryColorLight,
      //           BlendMode.srcIn,
      //         ),
      //       ),
      //       label: "Calender",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         Assets.svgs.icPersonFilled,
      //         colorFilter: ColorFilter.mode(
      //           dashboardController.currentScreenIndex.value == 2
      //               ? AppColors.primaryColor
      //               : AppColors.primaryColorLight,
      //           BlendMode.srcIn,
      //         ),
      //       ),
      //       label: "Profile",
      //     ),
      //   ],
      // ),
    );
  }
}
