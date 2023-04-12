class TaskModel {
  int? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? time;
  TaskStatus? status;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.time,
    this.status,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['start_date'] = startDate;
    data['end_date'] = startDate;
    data['time'] = time;
    data['status'] = status;
    return data;
  }
}

enum TaskStatus {
  inProgress,
  completed,
  pending,
}
