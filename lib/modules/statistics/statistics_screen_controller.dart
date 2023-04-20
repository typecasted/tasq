import 'package:get/get.dart';

class StatisticsController extends GetxController {
  List<MonthStates> statisticsList = [
    MonthStates(month: 'Jan', states: 30),
    MonthStates(month: 'Feb', states: 70),
    MonthStates(month: 'Mar', states: 30),
    MonthStates(month: 'Apr', states: 50),
    MonthStates(month: 'May', states: 20),
    MonthStates(month: 'Jun', states: 80),
    MonthStates(month: 'Jul', states: 50),
    MonthStates(month: 'Aug', states: 80),
    MonthStates(month: 'Sep', states: 60),
    MonthStates(month: 'Oct', states: 50),
    MonthStates(month: 'Nov', states: 10),
    MonthStates(month: 'Dec', states: 40),
  ];

  @override
  void onInit() {
    super.onInit();
  }
}

class MonthStates {
  final String month;
  final int states;

  MonthStates({
    required this.month,
    required this.states,
  });
}
