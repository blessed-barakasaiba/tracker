import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tracker/screens/add_log_screen.dart';
import '../model/daily_log.dart';
import '../services/hive_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.lazyBox<DailyLog>(HiveService.dailyBox);

    return Scaffold(
      appBar: AppBar(title: Text("Pelvic Tracker")),
      body: ValueListenableBuilder<LazyBox<DailyLog>>(
        valueListenable: box.listenable(),
        builder: (context, LazyBox<DailyLog> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No logs yet"));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: box.getAt(index),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();
                  final log = snapshot.data!;
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
        child: const Icon(Icons.add)),
    );
  }
}
