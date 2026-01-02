import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tracker/screens/add_log_screen.dart';
import '../model/daily_log.dart';
import '../services/hive_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final LazyBox<DailyLog> box;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Store all log dates for quick lookup
  Set<DateTime> loggedDates = {};

  @override
  void initState() {
    super.initState();
    box = Hive.lazyBox<DailyLog>(HiveService.dailyBox);
    _loadLoggedDates();
  }

  void _loadLoggedDates() async {
    final dates = <DateTime>{};
    for (int i = 0; i < box.length; i++) {
      final log = await box.getAt(i);
      if (log != null) {
        dates.add(DateTime(log.date.year, log.date.month, log.date.day));
      }
    }
    setState(() {
      loggedDates = dates;
    });
  }

  bool _isLogged(DateTime day) {
    final date = DateTime(day.year, day.month, day.day);
    return loggedDates.contains(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pelvic Tracker")),
      body: ValueListenableBuilder<LazyBox<DailyLog>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          _loadLoggedDates(); // refresh whenever Hive changes

          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime(2023, 1, 1),
                lastDay: DateTime(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    if (_isLogged(day)) {
                      return Container(
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _selectedDay != null
                    ? FutureBuilder<List<DailyLog>>(
                        future: _getLogsForDay(_selectedDay!),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                          final logs = snapshot.data!;
                          if (logs.isEmpty) return const Center(child: Text("No logs for this day"));
                          return ListView.builder(
                            itemCount: logs.length,
                            itemBuilder: (context, index) {
                              final log = logs[index];
                              return ListTile(
                                title: Text("Water: ${log.waterIntake}L"),
                                subtitle: Text(log.notes),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (log.alcohol)
                                      const Icon(Icons.local_bar, color: Colors.red),
                                    if (log.caffeine)
                                      const Icon(Icons.coffee, color: Colors.brown),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                    : const Center(child: Text("Select a day to see logs")),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddLogScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<DailyLog>> _getLogsForDay(DateTime day) async {
    final selectedLogs = <DailyLog>[];
    for (int i = 0; i < box.length; i++) {
      final log = await box.getAt(i);
      if (log != null &&
          log.date.year == day.year &&
          log.date.month == day.month &&
          log.date.day == day.day) {
        selectedLogs.add(log);
      }
    }
    return selectedLogs;
  }
}
