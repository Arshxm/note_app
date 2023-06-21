import 'package:hive/hive.dart';


class Time extends HiveObject {
  final int hour;
  final int minute;

  Time(this.hour, this.minute);
}