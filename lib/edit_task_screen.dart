import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/task.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  TextEditingController? textFieldTitle;
  TextEditingController? textFieldTask;

  var box = Hive.box<Task>('taskBox');

  Time? _time;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textFieldTask = TextEditingController(text: widget.task.task);
    textFieldTitle = TextEditingController(text: widget.task.title);

    _time = Time(hour: widget.task.time.hour, minute: widget.task.time.minute);
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
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
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: TextField(
                maxLength: 15,
                controller: textFieldTitle,
                focusNode: negahban1,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  labelText: 'Task Title',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: negahban1.hasFocus
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
                focusNode: negahban2,
                maxLines: 2,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  labelText: 'Task',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: negahban2.hasFocus
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
            showPicker(
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
                isInlinePicker: true,
                context: context,
                value: _time!,
                onChange: onTimeChanged),
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
    widget.task.time = _time!;
    widget.task.save();
  }
}
