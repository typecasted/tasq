import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final RxInt currentScreenIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final RxList<Widget> dashboardScreenList = <Widget>[].obs;

  @override
  void onInit() {
    super.onInit();
    initDashboardScreenList();
  }

  void initDashboardScreenList() {
    dashboardScreenList.add(const Center(child: Text('Home')));
    dashboardScreenList.add(const Center(child: Text('Calender')));
    dashboardScreenList.add(const Center(child: Text('Profile')));
  }

  void changeScreen(int index) {
    currentScreenIndex.value = index;
  }
}

DashboardController get dashboardController => Get.put(DashboardController());
