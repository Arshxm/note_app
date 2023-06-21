import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/task.dart';
import '../utility/utility.dart';
import '../widget/task_type_list.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode guardian1 = FocusNode();
  FocusNode guardian2 = FocusNode();

  TextEditingController? textFieldTitle;
  TextEditingController? textFieldTask;

  var box = Hive.box<Task>('taskBox');

  Time _time = Time(hour: 10, minute: 00);
  int _selectedTaskItemType = 0;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  void initState() {
    super.initState();

    textFieldTask = TextEditingController(text: widget.task.task);
    textFieldTitle = TextEditingController(text: widget.task.title);

    _time = Time(hour: widget.task.time.hour, minute: widget.task.time.minute);

    guardian1.addListener(() {
      setState(() {});
    });
    guardian2.addListener(() {
      setState(() {});
    });

    _selectedTaskItemType = widget.task.taskType.taskTypeEnum.index;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: TextField(
                maxLength: 25,
                controller: textFieldTitle,
                focusNode: guardian1,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  labelText: 'Task Title',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: guardian1.hasFocus
                          ? Color(0xff18DAA3)
                          : Color(0xffC5C5C5)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(color: Color(0xffC5C5C5), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff18DAA3))),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: TextField(
                controller: textFieldTask,
                focusNode: guardian2,
                maxLines: 2,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  labelText: 'Task',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: guardian2.hasFocus
                          ? Color(0xff18DAA3)
                          : Color(0xffC5C5C5)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(color: Color(0xffC5C5C5), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff18DAA3))),
                ),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  showPicker(
                      blurredBackground: true,
                      buttonsSpacing: 140,
                      elevation: 8,
                      cancelStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      okText: "Set",
                      okStyle: TextStyle(
                          color: Color(0xff18DAA3),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      accentColor: Color(0xff18DAA3),
                      context: context,
                      value: _time,
                      onChange: onTimeChanged),
                );
              },
              child: Material(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                elevation: 10,
                child: Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${_time.hour} : ${getMinUnderTen(_time)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 90,
                            color: Color(0xff18DAA3)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getTaskTypeList().length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTaskItemType = index;
                      });
                    },
                    child: TaskTypeItemList(
                      taskType: getTaskTypeList()[index],
                      selectedItemType: _selectedTaskItemType,
                      index: index,
                    ),
                  );
                }),
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff18DAA3),
                  minimumSize: Size(150, 50)),
              onPressed: () {
                addTask(textFieldTitle!.text, textFieldTask!.text);
                Navigator.of(context).pop();
              },
              child: Text(
                'Edit Task',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  addTask(String title, String task) {
    widget.task.task = textFieldTask!.text;
    widget.task.title = textFieldTitle!.text;
    widget.task.time = _time;
    widget.task.taskType = getTaskTypeList()[_selectedTaskItemType];
    widget.task.save();
  }

  String getMinUnderTen(Time time) {
    if (time.minute < 10) {
      return "0${time.minute}";
    } else {
      return "${time.minute}";
    }
  }
}
