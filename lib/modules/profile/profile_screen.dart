import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/modules/statistics/statistics_screen.dart';
import 'package:tasq/utils/app_colors.dart';

import '../../utils/app_strings.dart';
import '../add_user/add_user_screen.dart';
import 'my_profile/my_profile_screen.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController profileController;

  @override
  void initState() {
    super.initState();

    profileController = Get.put(ProfileController());
    profileController.onInit();
  }

  @override
  void dispose() {
    profileController.onClose();
    // profileController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Text(
          AppStrings.profile,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        child: Column(
          children: [
            /// header
            Obx(
              () => SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 45,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 55),
                            Text(
                              profileController.userData.value.firstName ?? '',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              profileController.userData.value.email ?? '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Completed Tasks : ${profileController.userData.value.completeTasks != null ? profileController.userData.value.completeTasks.toString() : ''}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            /// body
            Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                  leading: Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyProfileScreen(),
                      ),
                    );
                  },
                ),
                Obx(
                  () => profileController.isLoggedInAsManager.isFalse
                      ? Container()
                      : ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 40),
                          leading: Icon(
                            Icons.person_add_rounded,
                            color: AppColors.primaryColor,
                          ),
                          title: Text(
                            'Add User',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddUserScreen(
                                  managerEmail:
                                      profileController.userData.value.email ??
                                          "",
                                ),
                              ),
                            );
                          },
                        ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                  leading: Icon(
                    Icons.stacked_bar_chart_rounded,
                    color: AppColors.primaryColor,
                  ),
                  title: Text(
                    'Statistics',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StatisticsScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                  leading: Icon(
                    Icons.logout,
                    color: AppColors.primaryColor,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    profileController.logout(context: context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
