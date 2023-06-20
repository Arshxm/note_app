import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/add_task_screen.dart';
import 'package:note_app/home_screen.dart';
import 'package:note_app/task.dart';
import 'package:note_app/task_type.dart';
import 'package:note_app/time.dart';
import 'package:note_app/type_enum.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskTypeEnumAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TimeAdapter());
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'GR'),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
