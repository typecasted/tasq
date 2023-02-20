/// package imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// utils imports
import '../../utils/assets.gen.dart';

/// screen imports
import '../home/home_screen.dart';

class DashboardController extends GetxController {
  /// - [currentScreenIndex] variable is used to set the index of the current screen being showed in the dashboard.
  final RxInt currentScreenIndex = 0.obs;

  /// - [isLoading] is used for showing and hiding and loader at the time of screen initialization.
  final RxBool isLoading = false.obs;

  /// - [dashboardScreenList] variable is list of screen to be shown in the dashboard.
  final RxList<Widget> dashboardScreenList = <Widget>[].obs;

  /// - [navIconList] is list of navigation icons which is provided from [Assets.svgs]
  final RxList<String> navIconList = <String>[].obs;

  /// - [initDashboardScreenList] this function will be call in [initState] method of [Dashboard] widget.
  void initDashboardScreenList() async {
    isLoading.value = true;

    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    /// value of [currentScreenIndex] must be [0] at the time of dashboard initialization.
    currentScreenIndex.value = 0;

    /// we must clear the lists before the initialization otherwise it will keep adding the values in the list
    dashboardScreenList.clear();
    navIconList.clear();

    /// reinitialising the lists
    dashboardScreenList.addAll([
      const Center(child: HomeScreen()),
      const Center(child: Text('Calender')),
      const Center(child: Text('Profile')),
    ]);

    navIconList.addAll([
      Assets.svgs.icHomeFilled,
      Assets.svgs.icCalenderFilled,
      Assets.svgs.icPersonFilled,
    ]);

    isLoading.value = false;
  }

  void changeScreen(int index) {
    currentScreenIndex.value = index;
  }
}

DashboardController get dashboardController => Get.put(DashboardController());
