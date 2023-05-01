import 'package:flutter/material.dart';
import 'package:tasq/modules/organization_dashboard/assignee/assignee_screen.dart';
import 'package:tasq/utils/local_storage.dart';
import 'manager/manager_screen.dart';

class OrganizationDashboardScreen extends StatefulWidget {
  const OrganizationDashboardScreen({super.key});

  @override
  State<OrganizationDashboardScreen> createState() =>
      _OrganizationDashboardScreenState();
}

class _OrganizationDashboardScreenState
    extends State<OrganizationDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: LocalStorage.getIsLoggedInAsManager(),
      builder: (context, snapshot) {
        return snapshot.data != null
            ? snapshot.data!
                ? const ManagerScreen()
                : const AssigneeScreen()
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );

    //   return Scaffold(
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) {
    //               return const AddOrEditTaskScreen(
    //                 isEdit: false,
    //               );
    //             },
    //           ),
    //         ).then((value) {
    //           orgController.getTasksData(
    //             context: context,
    //           );
    //         });
    //       },
    //       backgroundColor: AppColors.primaryColor,
    //       child: const Icon(Icons.add),
    //     ),
    //     body: SafeArea(
    //       child: Obx(
    //         () => orgController.isLoading.value
    //             ? const Center(
    //                 child: CircularProgressIndicator(),
    //               )
    //             : Padding(
    //                 padding: EdgeInsets.symmetric(
    //                   vertical: Get.height * 0.02,
    //                   horizontal: Get.width * 0.05,
    //                 ),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     /// Day, Date and Notification icon

    //                     /// Greeting Message
    //                     Padding(
    //                       padding: EdgeInsets.symmetric(
    //                         vertical: Get.height * 0.03,
    //                       ),
    //                       child: Text(
    //                         "Organization Dashboard",
    //                         style: TextStyle(
    //                           fontFamily: FontFamily.poppins,
    //                           fontSize: Get.height * 0.025,
    //                           fontWeight: FontWeight.w700,
    //                         ),
    //                       ),
    //                     ),

    //                     /// My Priority Tasks
    //                     Text(
    //                       AppStrings.yourTasks,
    //                       style: TextStyle(
    //                         fontFamily: FontFamily.poppins,
    //                         fontSize: Get.height * 0.02,
    //                         fontWeight: FontWeight.w600,
    //                       ),
    //                     ),

    //                     SizedBox(
    //                       height: Get.height * 0.02,
    //                     ),

    //                     /// Priority Tasks slider
    //                     Expanded(
    //                       child: RefreshIndicator(
    //                         onRefresh: () async {
    //                           orgController.isLoading.value = true;

    //                           orgController.getTasksData(
    //                             context: context,
    //                           );
    //                           orgController.isLoading.value = false;
    //                         },
    //                         child: Obx(
    //                           () => orgController.taskList.isEmpty
    //                               ? Center(
    //                                   child: Text(
    //                                     "No Tasks Found",
    //                                     style: TextStyle(
    //                                       fontFamily: FontFamily.poppins,
    //                                       fontSize: Get.height * 0.02,
    //                                       fontWeight: FontWeight.w600,
    //                                     ),
    //                                   ),
    //                                 )
    //                               : ListView.builder(
    //                                   shrinkWrap: true,
    //                                   physics:
    //                                       const AlwaysScrollableScrollPhysics(),
    //                                   itemCount: orgController.taskList.length,
    //                                   itemBuilder: (context, index) {
    //                                     return GestureDetector(
    //                                       behavior: HitTestBehavior.translucent,
    //                                       onTap: () {
    //                                         Navigator.push(
    //                                           context,
    //                                           MaterialPageRoute(
    //                                             builder: (context) {
    //                                               return TaskDetailsScreen(
    //                                                 taskId: orgController
    //                                                         .taskList[index].id ??
    //                                                     "",
    //                                                 isPersonal: orgController
    //                                                         .taskList[index]
    //                                                         .isPersonal ??
    //                                                     false,
    //                                               );
    //                                             },
    //                                           ),
    //                                         ).then(
    //                                           (value) async {
    //                                             orgController.isLoading.value =
    //                                                 true;

    //                                             await orgController.getTasksData(
    //                                               context: context,
    //                                             );
    //                                             orgController.isLoading.value =
    //                                                 false;
    //                                           },
    //                                         );
    //                                       },
    //                                       child: Padding(
    //                                         padding: EdgeInsets.symmetric(
    //                                           vertical: Get.height * 0.01,
    //                                           // horizontal: Get.width * 0.02,
    //                                         ),
    //                                         child: Container(
    //                                           decoration: BoxDecoration(
    //                                             borderRadius:
    //                                                 BorderRadius.circular(10),
    //                                             // gradient: LinearGradient(
    //                                             //   colors: [
    //                                             //     AppColors.primaryColor,
    //                                             //     AppColors.primaryColorLight,
    //                                             //   ],
    //                                             //   begin: Alignment.topLeft,
    //                                             //   end: Alignment.bottomRight,
    //                                             // ),

    //                                             color: AppColors.primaryColorLight
    //                                                 .withOpacity(0.5),

    //                                             border: Border.all(
    //                                               color: AppColors.primaryColor,
    //                                               width: 1,
    //                                             ),
    //                                           ),
    //                                           height: Get.height * 0.18,
    //                                           width: Get.width * 0.35,
    //                                           padding: EdgeInsets.symmetric(
    //                                               horizontal: Get.width * 0.04,
    //                                               vertical: Get.height * 0.01),
    //                                           child: Column(
    //                                             mainAxisAlignment:
    //                                                 MainAxisAlignment.spaceEvenly,
    //                                             crossAxisAlignment:
    //                                                 CrossAxisAlignment.start,
    //                                             children: [
    //                                               Row(
    //                                                 mainAxisAlignment:
    //                                                     MainAxisAlignment
    //                                                         .spaceBetween,
    //                                                 children: [
    //                                                   Text(
    //                                                     orgController
    //                                                             .taskList[index]
    //                                                             .title ??
    //                                                         "",
    //                                                     style: TextStyle(
    //                                                       fontFamily:
    //                                                           FontFamily.poppins,
    //                                                       fontSize:
    //                                                           Get.height * 0.019,
    //                                                       fontWeight:
    //                                                           FontWeight.w600,
    //                                                     ),
    //                                                   ),

    //                                                   /// Task Status

    //                                                   Container(
    //                                                     padding:
    //                                                         EdgeInsets.symmetric(
    //                                                             horizontal: Get
    //                                                                     .width *
    //                                                                 0.02,
    //                                                             vertical:
    //                                                                 Get.height *
    //                                                                     0.005),
    //                                                     decoration: BoxDecoration(
    //                                                       borderRadius:
    //                                                           BorderRadius
    //                                                               .circular(5),
    //                                                       color: AppColors
    //                                                           .primaryColor,
    //                                                     ),
    //                                                     child: Text(
    //                                                       orgController
    //                                                               .taskList[index]
    //                                                               .status ??
    //                                                           "Task Status",
    //                                                       style: TextStyle(
    //                                                         fontFamily: FontFamily
    //                                                             .poppins,
    //                                                         fontSize: Get.height *
    //                                                             0.015,
    //                                                         fontWeight:
    //                                                             FontWeight.w400,
    //                                                         color: Colors.white,
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                 ],
    //                                               ),
    //                                               Text(
    //                                                 orgController.taskList[index]
    //                                                         .description ??
    //                                                     "",
    //                                                 maxLines: 3,
    //                                                 overflow:
    //                                                     TextOverflow.ellipsis,
    //                                                 style: TextStyle(
    //                                                   fontFamily:
    //                                                       FontFamily.poppins,
    //                                                   fontSize:
    //                                                       Get.height * 0.015,
    //                                                   fontWeight: FontWeight.w500,
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     );
    //                                   },
    //                                 ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //       ),
    //     ),
    //   );
  }
}
