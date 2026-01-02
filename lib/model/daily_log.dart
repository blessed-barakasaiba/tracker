import "package:hive/hive.dart";

part 'daily_log.g.dart';

@HiveType(typeId: 0)
class DailyLog extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  double waterIntake;

  @HiveField(2)
  bool alcohol;

  @HiveField(3)
  bool caffeine;

  @HiveField(4)
  String notes;

  DailyLog({
    required this.date,
    this.waterIntake = 0,
    this.alcohol = false,
    this.caffeine = false,
    this.notes = "",
  });
}
