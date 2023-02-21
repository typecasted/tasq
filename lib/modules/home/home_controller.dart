/// packages import
import 'package:get/get.dart';

/// model import
import 'package:tasq/modules/home/models/priority_task_model.dart';
import 'models/daily_task_model.dart';

class HomeController extends GetxController {
  /// - [isLoading] is used for showing and hiding and loader at the time of screen initialization.
  final RxBool isLoading = false.obs;

  /// - [dateTimeString] variable is used to show day and date at the top left side.
  final RxString dateTimeString = ''.obs;

  /// - [greetingMessage] is used to show greetings message.
  final RxString greetingMessage = "".obs;

  final RxList<PriorityTaskModel> priorityTasks = <PriorityTaskModel>[].obs;

  final RxList<DailyTaskModel> dailyTasks = <DailyTaskModel>[].obs;

  /// - [initHomeScreenList] this function will be call in [initState] method of [Home] widget.
  void initHomeScreenList() async {
    isLoading.value = true;

    /// here i've put a delay to replicate api call.
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    getDayAndDateValues();

    getGreetingsMessage();

    await getTasksData();
    isLoading.value = false;
  }

  /// - [getDayAndDateValues] function is used to get the current Day and Date.
  void getDayAndDateValues() {
    String weekDay = "";
    String month = "";

    switch (DateTime.now().weekday) {
      case DateTime.monday:
        weekDay = "Monday";
        break;
      case DateTime.tuesday:
        weekDay = "Tuesday";
        break;
      case DateTime.wednesday:
        weekDay = "Wednesday";
        break;
      case DateTime.thursday:
        weekDay = "Thursday";
        break;
      case DateTime.friday:
        weekDay = "Friday";
        break;
      case DateTime.saturday:
        weekDay = "Saturday";
        break;
      case DateTime.sunday:
        weekDay = "Sunday";
        break;
      default:
    }

    switch (DateTime.now().month) {
      case DateTime.january:
        month = 'Jan.';
        break;
      case DateTime.february:
        month = 'Feb.';
        break;
      case DateTime.march:
        month = 'Mar.';
        break;
      case DateTime.april:
        month = 'Apr.';
        break;
      case DateTime.may:
        month = 'May';
        break;
      case DateTime.june:
        month = 'Jun.';
        break;
      case DateTime.july:
        month = 'Jul.';
        break;
      case DateTime.august:
        month = 'Aug.';
        break;
      case DateTime.september:
        month = 'Sept.';
        break;
      case DateTime.october:
        month = 'Oct.';
        break;
      case DateTime.november:
        month = 'Nov.';
        break;
      case DateTime.december:
        month = 'Dec.';
        break;
      default:
        month = 'Err';
        break;
    }

    dateTimeString.value =
        '$weekDay, $month ${DateTime.now().day} ${DateTime.now().year}';
  }

  /// [getGreetingsMessage] get greetings message for user.
  /// todo : randomize the greeting message.
  void getGreetingsMessage() {
    greetingMessage.value = "Welcome Kunal!!!";
  }

  getTasksData() async {
    priorityTasks.value = [
      PriorityTaskModel(
        title: "Task 1",
        description: "Task 1 description",
        priority: 1,
      ),
      PriorityTaskModel(
        title: "Task 2",
        description: "Task 2 description",
        priority: 2,
      ),
      PriorityTaskModel(
        title: "Task 3",
        description: "Task 3 description",
        priority: 3,
      ),
      PriorityTaskModel(
        title: "Task 4",
        description: "Task 4 description",
        priority: 4,
      ),
      PriorityTaskModel(
        title: "Task 5",
        description: "Task 5 description",
        priority: 5,
      ),
    ];

    dailyTasks.value = [
      DailyTaskModel(title: "Task 1", isCompleted: true),
      DailyTaskModel(title: "Task 2", isCompleted: true),
      DailyTaskModel(title: "Task 3", isCompleted: true),
      DailyTaskModel(title: "Task 4", isCompleted: false),
      DailyTaskModel(title: "Task 5", isCompleted: false),
      DailyTaskModel(title: "Task 6", isCompleted: false),
      DailyTaskModel(title: "Task 7", isCompleted: false),
    ];
  }
}

HomeController get homeController => Get.put(HomeController());
