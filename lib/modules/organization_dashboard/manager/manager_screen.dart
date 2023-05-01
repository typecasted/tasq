import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/modules/organization_dashboard/manager/manager_controller.dart';

import '../../../utils/app_strings.dart';
import '../../../utils/fonts.gen.dart';
import '../task_listing/task_listing_screen.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({super.key});

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  late ManagerController managerController;

  @override
  void initState() {
    super.initState();
    managerController = Get.put(ManagerController());
    managerController.getManagerInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
            horizontal: Get.width * 0.05,
          ),
          child: Obx(
            () => managerController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
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
                        AppStrings.yourAssignees,
                        style: TextStyle(
                          fontFamily: FontFamily.poppins,
                          fontSize: Get.height * 0.02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(
                        height: Get.height * 0.02,
                      ),

                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: managerController.assigneeList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TaskListingScreen(
                                        assignee: managerController
                                            .assigneeList[index],
                                      );
                                    },
                                  ),
                                ).then(
                                  (value) {
                                    managerController.getManagerInfo();
                                  },
                                );
                              },
                              title: Text(
                                managerController.assigneeList[index].email ??
                                    "",
                                style: TextStyle(
                                  fontFamily: FontFamily.poppins,
                                  fontSize: Get.height * 0.02,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                managerController
                                        .assigneeList[index].designation ??
                                    "",
                                style: TextStyle(
                                  fontFamily: FontFamily.poppins,
                                  fontSize: Get.height * 0.018,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return TaskListingScreen(
                                          assignee: managerController
                                              .assigneeList[index],
                                        );
                                      },
                                    ),
                                  ).then(
                                    (value) {
                                      managerController.getManagerInfo();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: Get.height * 0.02,
                                ),
                              ),
                            );
                          },
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
