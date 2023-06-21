import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/data/task_type.dart';


part 'task.g.dart';

@HiveType(typeId: 3)
class Task extends HiveObject {
  Task(
      {required this.title,
      required this.task,
      this.isDone = false,
      required this.time,
      required this.taskType});

  @HiveField(0)
  String title;

  @HiveField(1)
  String task;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  Time time;

  @HiveField(4)
  TaskType taskType;
}
