import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/add_task_screen.dart';
import 'package:note_app/task.dart';
import 'package:note_app/task_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputText = '';
  var controller = TextEditingController();

  var taskBox = Hive.box<Task>("taskBox");

  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: ((context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notif) {
                  if (notif.direction == ScrollDirection.forward) {
                    setState(() {
                      isFabVisible = true;
                    });
                  }
                  if (notif.direction == ScrollDirection.reverse) {
                    setState(() {
                      isFabVisible = false;
                    });
                  }
                  return true;
                },
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    var taskB = taskBox.values.toList()[index];
                    return getTaskWidget(taskB);
                  }),
                  itemCount: taskBox.values.length,
                ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          backgroundColor: Color(0xff18DAA3),
          child: Icon(Icons.add, size: 30),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
        ),
      ),
    );
    
  }

  Widget getTaskWidget(Task taskB) {
    return Dismissible(
      onDismissed: (direction) {
        taskB.delete();
      },
      key: UniqueKey(),
      child: TaskWidget(task: taskB ),
    );
  }

  
}
