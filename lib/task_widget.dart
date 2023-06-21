import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note_app/edit_task_screen.dart';

import 'data/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});

  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  var taskBox = Hive.box<Task>("taskBox");

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return InkWell(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: getMainItem(
              widget.task.title, widget.task.task, widget.task.taskType.image),
        ),
      ),
    );
  }

  Widget getMainItem(title, task, taskTypeImage) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(taskTypeImage),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      "$title",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  getCheckBox()
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$task",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  Container(
                    width: 100,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Color(0xff18DAA3),
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/icon_time.png'),
                          Text(
                            '${widget.task.time.hour}:${getMinUnderTen(widget.task.time)}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditTaskScreen(
                                task: widget.task,
                              )));
                    },
                    child: Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color(0xffE2F6F1),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('images/icon_edit.png'),
                            Text(
                              "Edit",
                              style: TextStyle(
                                  color: Color(0xff18DAA3),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  MSHCheckbox getCheckBox() {
    return MSHCheckbox(
      size: 26,
      value: widget.task.isDone,
      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
        checkedColor: Color(0xff18DAA3),
      ),
      style: MSHCheckboxStyle.fillScaleCheck,
      onChanged: (selected) {
        setState(() {
          widget.task.isDone = selected;
        });
      },
    );
  }

  String getMinUnderTen(Time time) {
    if (time.minute < 10) {
      return "0${time.minute}";
    } else {
      return "${time.minute}";
    }
  }
}
