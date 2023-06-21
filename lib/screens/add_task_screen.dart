import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/data/task.dart';

import '../utility/utility.dart';
import '../widget/task_type_list.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode guardian1 = FocusNode();
  FocusNode guardian2 = FocusNode();

  Time _time = Time(hour: 12, minute: 00);

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  final TextEditingController textFieldTitle = TextEditingController();
  final TextEditingController textFieldTask = TextEditingController();

  int _selectedTaskItemType = 0;

  var box = Hive.box<Task>('taskBox');

  @override
  void initState() {
    super.initState();
    guardian1.addListener(() {
      setState(() {});
    });
    guardian2.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
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
                addTask(textFieldTitle.text, textFieldTask.text);
                Navigator.of(context).pop();
              },
              child: Text(
                'Add Task',
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
    //add task
    final time = Time(hour: _time.hour, minute: _time.minute);
    var taskAndTitle = Task(
        title: title,
        task: task,
        time: time,
        taskType: getTaskTypeList()[_selectedTaskItemType]);
    box.add(taskAndTitle);
  }

  String getMinUnderTen(Time time) {
    if (time.minute < 10) {
      return "0${time.minute}";
    } else {
      return "${time.minute}";
    }
  }
}

class TimeAdapter extends TypeAdapter<Time> {
  @override
  final int typeId = 1; // Unique identifier for the adapter

  @override
  Time read(BinaryReader reader) {
    final hour = reader.readInt();
    final minute = reader.readInt();
    return Time(
      hour: hour,
      minute: minute,
    );
  }

  @override
  void write(BinaryWriter writer, Time obj) {
    writer.writeInt(obj.hour);
    writer.writeInt(obj.minute);
  }
}
