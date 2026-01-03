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
  bool chinese;

  @HiveField(5)
  bool mchicha;

  @HiveField(6)
  int eggs;

  @HiveField(7)
  bool carrot;

  @HiveField(8)
  bool onion;

  @HiveField(9)
  bool tomato;

  @HiveField(10)
  bool figiri;

  @HiveField(11)
  bool nuts;

  @HiveField(12)
  String notes;

  DailyLog({
    required this.date,
    this.waterIntake = 0,
    this.alcohol = false,
    this.caffeine = false,
    this.chinese=false,
    this.mchicha=false,
    this.eggs=0,
    this.carrot=false,
    this.onion=false,
    this.tomato=false,
    this.figiri=false,
    this.nuts=false,
    this.notes = "",
  });
}
