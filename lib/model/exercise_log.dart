import 'package:hive/hive.dart';

part "exercise_log.g.dart";

@HiveType(typeId: 1)
class ExerciseLog extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  String exerciseName;

  @HiveField(2)
  int durationMinutes;

  @HiveField(3)
  bool completed;

  ExerciseLog({
    required this.date,
    this.exerciseName = "",
    this.durationMinutes = 0,
    this.completed = false,
  });
}
