class PriorityTaskModel {
  final String title;
  final String description;
  final String? date;
  final String? time;
  final int? priority;
  final String? status;
  final String? id;

  PriorityTaskModel({
    required this.title,
    required this.description,
    this.date,
    this.time,
    this.priority,
    this.status,
    this.id,
  });
}