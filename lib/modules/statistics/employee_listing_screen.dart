import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/modules/statistics/statistics_screen_controller.dart';

import '../../utils/app_strings.dart';
import '../../utils/fonts.gen.dart';
import 'statistics_screen.dart';

class EmployeeListingScreenStats extends StatefulWidget {
  /// [EmployeeListingScreenStats] is used for the stats section when the user is logged in as [manager].
  /// it will show the list of the employee under the manager.
  /// user can see the stats of the employee by clicking on the employee name.
  const EmployeeListingScreenStats({
    super.key,
    required this.statisticsController,
  });

  final StatisticsController statisticsController;

  @override
  State<EmployeeListingScreenStats> createState() =>
      _EmployeeListingScreenStatsState();
}

class _EmployeeListingScreenStatsState
    extends State<EmployeeListingScreenStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.03,
          horizontal: Get.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              child: widget.statisticsController.assigneeList.isEmpty
                  ? Center(
                      child: Text(
                        "No Assignees",
                        style: TextStyle(
                          fontFamily: FontFamily.poppins,
                          fontSize: Get.height * 0.02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          widget.statisticsController.assigneeList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          onTap: () {
                            widget.statisticsController.isStatsLoading.value =
                                true;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return StatisticsGridScreen(
                                    statisticsController:
                                        widget.statisticsController,
                                    userEmail: widget.statisticsController
                                        .assigneeList[index].email,
                                  );
                                },
                              ),
                            );
                          },
                          title: Text(
                            widget.statisticsController.assigneeList[index]
                                    .email ??
                                "",
                            style: TextStyle(
                              fontFamily: FontFamily.poppins,
                              fontSize: Get.height * 0.02,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            widget.statisticsController.assigneeList[index]
                                    .designation ??
                                "",
                            style: TextStyle(
                              fontFamily: FontFamily.poppins,
                              fontSize: Get.height * 0.018,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: Get.height * 0.02,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
