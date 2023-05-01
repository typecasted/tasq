import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tasq/utils/app_colors.dart';
import 'package:tasq/utils/app_strings.dart';
import 'package:tasq/utils/fonts.gen.dart';

import '../models/task_model.dart';
import 'add_task_controller.dart';

class AddOrEditTaskScreen extends StatefulWidget {
  final bool isEdit;
  final TaskModel? task;
  const AddOrEditTaskScreen({
    super.key,
    required this.isEdit,
    this.task,
  });

  @override
  State<AddOrEditTaskScreen> createState() => _AddOrEditTaskScreenState();
}

class _AddOrEditTaskScreenState extends State<AddOrEditTaskScreen> {
  late AddTaskController addTaskController;

  @override
  void initState() {
    super.initState();
    addTaskController = Get.put(AddTaskController());
    addTaskController.onInitStateCalled(widget: widget);
  }

  @override
  void dispose() {
    addTaskController.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          !(widget.isEdit) ? AppStrings.addTask : AppStrings.editTask,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: FontFamily.poppins,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primaryColor,
              size: 18,
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.06,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),

                    /// start time and end time section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: FontFamily.poppins,
                                color: AppColors.primaryColor,
                              ),
                            ),

                            SizedBox(
                              height: Get.height * 0.01,
                            ),

                            /// start time picker
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  color: AppColors.primaryColorLight,
                                  width: 1,
                                ),
                              ),
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  addTaskController.selectDate(
                                    context: context,
                                    isStartDate: true,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      color: AppColors.primaryColor,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Obx(
                                      () => Text(
                                        '${addTaskController.startDate.value.day}/${addTaskController.startDate.value.month}/${addTaskController.startDate.value.year}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamily.poppins,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.end,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: FontFamily.poppins,
                                color: AppColors.primaryColor,
                              ),
                            ),

                            SizedBox(
                              height: Get.height * 0.01,
                            ),

                            /// start time picker
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  color: AppColors.primaryColorLight,
                                  width: 1,
                                ),
                              ),
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  addTaskController.selectDate(
                                    context: context,
                                    isStartDate: false,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      color: AppColors.primaryColor,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Obx(
                                      () => Text(
                                        '${addTaskController.endDate.value.day}/${addTaskController.endDate.value.month}/${addTaskController.endDate.value.year}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamily.poppins,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: Get.height * 0.03,
                    ),

                    /// task title section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: FontFamily.poppins,
                            color: AppColors.primaryColor,
                          ),
                        ),

                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        /// task title text field

                        TextFormField(
                          controller: addTaskController.titleController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                          ],
                          autocorrect: true,
                          decoration: InputDecoration(
                            /// task title text field
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(
                                color: AppColors.primaryColorLight,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(
                                color: AppColors.primaryColorLight,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(
                                color: AppColors.primaryColorLight,
                                width: 1,
                              ),
                            ),
                            hintText: AppStrings.typeHere,
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.poppins,
                            ),
                          ),
                        ),

                        /// category selection section

                        // SizedBox(
                        //   height: Get.height * 0.03,
                        // ),

                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       AppStrings.category,
                        //       style: TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w500,
                        //         fontFamily: FontFamily.poppins,
                        //         color: AppColors.primaryColor,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: Get.height * 0.01,
                        //     ),

                        //     /// category selection
                        //     Obx(
                        //       () {
                        //         return Row(
                        //           children: [
                        //             Expanded(
                        //               child: GestureDetector(
                        //                 onTap: () {
                        //                   addTaskController.selectedCategory
                        //                       .value = TaskCategory.daily;
                        //                 },
                        //                 child: Container(
                        //                   alignment: Alignment.center,
                        //                   padding: const EdgeInsets.symmetric(
                        //                     horizontal: 15,
                        //                     vertical: 15,
                        //                   ),
                        //                   decoration: BoxDecoration(
                        //                     color: addTaskController
                        //                                 .selectedCategory
                        //                                 .value ==
                        //                             TaskCategory.daily
                        //                         ? AppColors.primaryColor
                        //                         : Colors.white,
                        //                     borderRadius:
                        //                         BorderRadius.circular(7),
                        //                     border: Border.all(
                        //                       color:
                        //                           AppColors.primaryColorLight,
                        //                       width: 1,
                        //                     ),
                        //                   ),
                        //                   child: Text(
                        //                     AppStrings.dailyTask,
                        //                     style: TextStyle(
                        //                       fontSize: 12,
                        //                       fontWeight: FontWeight.w500,
                        //                       fontFamily: FontFamily.poppins,
                        //                       color: addTaskController
                        //                                   .selectedCategory
                        //                                   .value ==
                        //                               TaskCategory.daily
                        //                           ? Colors.white
                        //                           : AppColors.primaryColor,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(
                        //               width: Get.width * 0.04,
                        //             ),
                        //             Expanded(
                        //               child: GestureDetector(
                        //                 onTap: () {
                        //                   addTaskController.selectedCategory
                        //                       .value = TaskCategory.priority;
                        //                 },
                        //                 child: Container(
                        //                   alignment: Alignment.center,
                        //                   padding: const EdgeInsets.symmetric(
                        //                     horizontal: 15,
                        //                     vertical: 15,
                        //                   ),
                        //                   decoration: BoxDecoration(
                        //                     color: addTaskController
                        //                                 .selectedCategory
                        //                                 .value ==
                        //                             TaskCategory.priority
                        //                         ? AppColors.primaryColor
                        //                         : Colors.white,
                        //                     borderRadius:
                        //                         BorderRadius.circular(7),
                        //                     border: Border.all(
                        //                       color:
                        //                           AppColors.primaryColorLight,
                        //                       width: 1,
                        //                     ),
                        //                   ),
                        //                   child: Text(
                        //                     AppStrings.priorityTask,
                        //                     style: TextStyle(
                        //                       fontSize: 12,
                        //                       fontWeight: FontWeight.w500,
                        //                       fontFamily: FontFamily.poppins,
                        //                       color: addTaskController
                        //                                   .selectedCategory
                        //                                   .value ==
                        //                               TaskCategory.priority
                        //                           ? Colors.white
                        //                           : AppColors.primaryColor,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),

                    SizedBox(
                      height: Get.height * 0.03,
                    ),

                    /// drop down section
                    /// assignee selection section

                    Obx(
                      () => !addTaskController.isManager.value
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.assignee,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.poppins,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),

                                /// category selection
                                Obx(
                                  () {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                          color: AppColors.primaryColorLight,
                                          width: 1,
                                        ),
                                      ),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        isDense: true,
                                        menuMaxHeight: Get.height * 0.3,
                                        value: addTaskController
                                            .selectedAssignee.value,
                                        onChanged: (value) {
                                          addTaskController
                                              .selectedAssignee.value = value!;
                                        },
                                        items: List.generate(
                                          addTaskController.assigneeList.length,
                                          (index) => DropdownMenuItem(
                                            value: addTaskController
                                                .assigneeList[index],
                                            child: Text(
                                              addTaskController
                                                  .assigneeList[index],
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: FontFamily.poppins,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                              ],
                            ),
                    ),

                    /// task description section

                    Text(
                      AppStrings.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.poppins,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    SizedBox(
                      height: Get.height * 0.01,
                    ),

                    /// task description text field

                    TextFormField(
                      controller: addTaskController.descriptionController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                      autocorrect: true,
                      maxLines: 5,
                      decoration: InputDecoration(
                        /// task description text field
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: AppColors.primaryColorLight,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: AppColors.primaryColorLight,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: AppColors.primaryColorLight,
                            width: 1,
                          ),
                        ),
                        hintText: AppStrings.typeHere,
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamily.poppins,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: Get.height * 0.03,
                    ),

                    /// create task button
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: Get.width * 0.9,
                        child: TextButton(
                          onPressed: () {
                            addTaskController.createOrEditTask(
                              isEdit: widget.isEdit,
                              task: widget.task,
                              context: context,
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: Text(
                            !(widget.isEdit)
                                ? AppStrings.createTask
                                : AppStrings.editTask,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.poppins,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
