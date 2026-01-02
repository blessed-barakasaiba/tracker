import 'package:flutter/material.dart';
import 'package:tracker/model/daily_log.dart';
import 'package:tracker/services/hive_service.dart';

class AddLogScreen extends StatefulWidget {
  const AddLogScreen({super.key});

  @override
  State<AddLogScreen> createState() => _AddLogScreenState();
}

class _AddLogScreenState extends State<AddLogScreen> {
  double _WaterInTake = 0;
  bool _alcohol = false;
  bool _caffeine = false;
  final TextEditingController _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _saveLog() async {
    if (!_formKey.currentState!.validate()) return;

    final log = DailyLog(
      date: DateTime.now(),
      waterIntake: _WaterInTake,
      alcohol: _alcohol,
      caffeine: _caffeine,
      notes: _notesController.text,
    );

    await HiveService.addDailyLog(log);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add daily Log")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text("Water Intake litres: ${_WaterInTake.toStringAsFixed(1)}"),
            Slider(
              value: _WaterInTake,
              min: 0,
              max: 5,
              divisions: 50,
              label: _WaterInTake.toStringAsFixed(1),
              onChanged: (val) => setState(() {
                _WaterInTake = val;
              }),
            ),

            CheckboxListTile(
              title: const Text("Alcohol"),
              value: _alcohol,
              onChanged: (val) => setState(() {
                _alcohol = val!;
              }),
            ),

            CheckboxListTile(
              value: _caffeine,
              title: const Text("Caffein"),
              onChanged: (val) => setState(() {
                _caffeine = val!;
              }),
            ),

            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(labelText: "Notes"),
              maxLines: 3,
            ),

            ElevatedButton(onPressed: _saveLog, child: const Text("Save log")),
          ],
        ),
      ),
    );
  }
}
