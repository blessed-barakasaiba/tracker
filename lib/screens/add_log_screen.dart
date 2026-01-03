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
  bool _mchicha = false;
  bool _chinese = false;
  bool _carrot = false;
  bool _figiri = false;
  int _eggs = 0;
  bool _onion = false;
  bool _tomato = false;
  bool _nuts = false;

  final TextEditingController _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _saveLog() async {
    if (!_formKey.currentState!.validate()) return;

    final log = DailyLog(
      date: DateTime.now(),
      waterIntake: _WaterInTake,
      alcohol: _alcohol,
      caffeine: _caffeine,
      mchicha: _mchicha,
      chinese: _chinese,
      carrot: _carrot,
      figiri: _figiri,
      eggs: _eggs,
      onion: _onion,
      tomato: _tomato,
      nuts: _nuts,
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
        child: ListView(
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
          
              Text("Eggs: ${_eggs.toStringAsFixed(1)}"),
              Slider(
                value: _eggs.toDouble(),
                min: 0,
                max: 5,
                divisions: 5,
                label: '$_eggs eggs',
                onChanged: (val) => setState(() {
                  _eggs = val.round();
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
          
              CheckboxListTile(
                value: _carrot,
                title: const Text("Carrot"),
                onChanged: (val) => setState(() {
                  _carrot = val!;
                }),
              ),
          
              CheckboxListTile(
                value: _mchicha,
                title: const Text("Mchicha"),
                onChanged: (val) => setState(() {
                  _mchicha = val!;
                }),
              ),
          
              CheckboxListTile(
                value: _chinese,
                title: const Text("Chinese"),
                onChanged: (val) => setState(() {
                  _chinese = val!;
                }),
              ),
          
              CheckboxListTile(
                value: _figiri,
                title: const Text("Figiri"),
                onChanged: (val) => setState(() {
                  _figiri = val!;
                }),
              ),
          
              CheckboxListTile(
                value: _onion,
                title: const Text("Onion"),
                onChanged: (val) => setState(() {
                  _onion = val!;
                }),
              ),
          
              CheckboxListTile(
                value: _nuts,
                title: const Text("Nuts"),
                onChanged: (val) => setState(() {
                  _nuts = val!;
                }),
              ),
          
              CheckboxListTile(
                value: _tomato,
                title: const Text("Tomato"),
                onChanged: (val) => setState(() {
                  _tomato = val!;
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
