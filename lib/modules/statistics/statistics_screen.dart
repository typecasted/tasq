import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/fonts.gen.dart';
import 'statistics_screen_controller.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  StatisticsController statisticsController = Get.put(StatisticsController());

  @override
  void initState() {
    super.initState();
    statisticsController.getStatistics(context: context);
  }

  @override
  void dispose() {
    statisticsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          AppStrings.statistics,
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
              child: Obx(() => statisticsController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: statisticsController.statisticsMap.length,
                          itemBuilder: (context, index) {
                            return StatisticCard(
                              title: statisticsController.statisticsMap.keys
                                  .toList()[index],
                              value: statisticsController.statisticsMap.values
                                  .toList()[index]
                                  .toString(),
                            );
                          },
                        )
                  // : SingleChildScrollView(
                  //     child: Column(
                  //       children: [
                  //         /// total tasks and completed tasks cards.

                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           children: [
                  //             StatisticCard(),
                  //             Card(
                  //               elevation: 5,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(20),
                  //               ),
                  //               child: Container(
                  //                 width: Get.width * 0.4,
                  //                 height: Get.height * 0.15,
                  //                 padding: const EdgeInsets.all(15),
                  //                 child: Column(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceEvenly,
                  //                   // crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       AppStrings.completedTasks,
                  //                       style: const TextStyle(
                  //                         fontSize: 12,
                  //                         fontWeight: FontWeight.w400,
                  //                         fontFamily: FontFamily.poppins,
                  //                       ),
                  //                     ),
                  //                     const Text(
                  //                       '99',
                  //                       style: TextStyle(
                  //                         fontSize: 22,
                  //                         fontWeight: FontWeight.w600,
                  //                         fontFamily: FontFamily.poppins,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),

                  //         /// 2 column grid view for tasks and completed tasks.

                  //         const SizedBox(
                  //           height: 20,
                  //         ),

                  //         GridView.count(
                  //           shrinkWrap: true,
                  //           primary: false,
                  //           padding: const EdgeInsets.all(20),
                  //           crossAxisSpacing: 10,
                  //           mainAxisSpacing: 10,
                  //           crossAxisCount: 2,
                  //           children: List.generate(
                  //             statisticsController.statisticsList.length,
                  //             (index) {
                  //               return Column(
                  //                 children: [
                  //                   Text(statisticsController
                  //                       .statisticsList[index].month),
                  //                   const SizedBox(
                  //                     height: 20,
                  //                   ),
                  //                   SizedBox(
                  //                     height: 80,
                  //                     width: 80,
                  //                     child: CircularProgressIndicator(
                  //                       value: statisticsController
                  //                               .statisticsList[index]
                  //                               .states /
                  //                           100,
                  //                       strokeWidth: 10,
                  //                       backgroundColor: Colors.grey[300],
                  //                       valueColor:
                  //                           AlwaysStoppedAnimation<Color>(
                  //                         AppColors.primaryColor,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),

                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.find<StatisticsController>().onStatisticsTileTap(
          context: context,
          status: title,
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: Get.width * 0.4,
          height: Get.height * 0.15,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppins,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.poppins,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
