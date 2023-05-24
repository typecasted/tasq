import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/common_widgets/common_text_field.dart';
import 'package:tasq/utils/app_colors.dart';

import 'remarks_controller.dart';

class RemarkScreen extends StatefulWidget {
  final String taskId;

  const RemarkScreen({
    super.key,
    required this.taskId,
  });

  @override
  State<RemarkScreen> createState() => _RemarkScreenState();
}

class _RemarkScreenState extends State<RemarkScreen> {
  late RemarksController remarksController;

  @override
  void initState() {
    super.initState();
    remarksController = Get.put(RemarksController());
    remarksController.remarksTextController = TextEditingController();
    remarksController.getRemarks(
      taskId: widget.taskId,
      context: context,
    );
  }

  @override
  void dispose() {
    remarksController.remarksTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          'Remarks',
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => remarksController.isLoading.isTrue
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : remarksController.remarks.isEmpty
                        ? Center(
                            child: Text(
                              'No remarks yet',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: Get.width * 0.04,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: remarksController.remarks.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: Get.width * 3,
                                margin: EdgeInsets.only(
                                  bottom: Get.height * 0.02,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.04,
                                  vertical: Get.height * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  color: remarksController
                                              .userData.body!.model!.email ==
                                          remarksController
                                              .remarks[index].email!
                                      ? AppColors.primaryColorLight
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(
                                        0,
                                        3,
                                      ),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      remarksController.remarks[index].email!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: Get.width * 0.04,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Text(
                                      remarksController.remarks[index].message!,
                                      style: TextStyle(
                                        fontSize: Get.width * 0.05,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ),

            /// text field and button to add remarks

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  // height: Get.height * 0.06,
                  width: Get.width * 0.7,
                  child: CommonTextField(
                    hintText: 'Add remarks',
                    textInputType: TextInputType.text,
                    textEditingController:
                        remarksController.remarksTextController,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                IconButton(
                  onPressed: () {
                    remarksController.addRemarks(
                      taskId: widget.taskId,
                      context: context,
                    );
                  },
                  icon: Icon(
                    Icons.send_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
