import 'package:flutter/material.dart';
import '../data/task_type.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedItemType,
  });

  TaskType taskType;

  int index;
  int selectedItemType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (selectedItemType == index)
            ? Color(0xff18DAA3)
            : Colors.transparent,
        border: Border.all(
            color:
                (selectedItemType == index) ? Color(0xff18DAA3) : Colors.grey,
            width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: EdgeInsets.all(10),
      width: 140,
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: (selectedItemType == index) ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
