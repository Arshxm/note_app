
import 'package:hive/hive.dart';

part "type_enum.g.dart";

@HiveType(typeId: 5)
enum TaskTypeEnum{

  @HiveField(0)
  working,

  @HiveField(1)
  meeting,

  @HiveField(2)
  meditating,

  @HiveField(3)
  payingBills,

  @HiveField(4)
  workMeeting,

  @HiveField(5)
  workout, 
}