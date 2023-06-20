import 'package:note_app/task_type.dart';
import 'package:note_app/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
      image: "images/hard_working.png",
      title: 'Working',
      taskTypeEnum: TaskTypeEnum.working,
    ),
    TaskType(
      image: "images/social_frends.png",
      title: 'Meeting',
      taskTypeEnum: TaskTypeEnum.meeting,
    ),
    TaskType(
      image: "images/meditate.png",
      title: 'Meditating',
      taskTypeEnum: TaskTypeEnum.meditating,
    ),
    TaskType(
      image: "images/banking.png",
      title: 'Pay the bills',
      taskTypeEnum: TaskTypeEnum.payingBills,
    ),
    TaskType(
      image: "images/work_meeting.png",
      title: 'Work Meeting',
      taskTypeEnum: TaskTypeEnum.workMeeting,
    ),
    TaskType(
      image: "images/workout.png",
      title: 'Workout',
      taskTypeEnum: TaskTypeEnum.workout,
    ),
  ];

  return list;
}
