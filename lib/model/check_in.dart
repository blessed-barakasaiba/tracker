import 'package:hive/hive.dart';

part 'check_in.g.dart';

@HiveType(typeId: 2)
class CheckIn extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int energy;

  @HiveField(2)
  int stress;

  @HiveField(3)
  int sleep;

  @HiveField(4)
  int mood;

  CheckIn({
    required this.date,
    this.energy = 0,
    this.stress = 0,
    this.sleep = 0,
    this.mood = 0,
  });
}
