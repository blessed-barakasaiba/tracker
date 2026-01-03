import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/check_in.dart';
import '../model/daily_log.dart';
import '../model/exercise_log.dart';

class HiveService {
  static const String dailyBox = "daily_log";
  static const String exerciseBox = "exercise_log";
  static const String checkInBox = "checkins";
  

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DailyLogAdapter());
    Hive.registerAdapter(CheckInAdapter());
    Hive.registerAdapter(ExerciseLogAdapter());

    await Hive.openLazyBox<DailyLog>(dailyBox);
    await Hive.openLazyBox<CheckIn>(checkInBox);
    await Hive.openLazyBox<ExerciseLog>(exerciseBox);
  }

  static Future<void> addDailyLog(DailyLog log) async {
    final box = await Hive.lazyBox<DailyLog>(dailyBox);
    final key = _dateKey(log.date);
    await box.put(key,log);
  }

  static String _dateKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
  
  static DailyLog? getLogForDay(DateTime date) {
    final box = Hive.box<DailyLog>(dailyBox);
    return box.get(_dateKey(date));
  }
}
