// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyLogAdapter extends TypeAdapter<DailyLog> {
  @override
  final int typeId = 0;

  @override
  DailyLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyLog(
      date: fields[0] as DateTime,
      waterIntake: fields[1] as double,
      alcohol: fields[2] as bool,
      caffeine: fields[3] as bool,
      chinese: fields[4] as bool,
      mchicha: fields[5] as bool,
      eggs: fields[6] as double,
      carrot: fields[7] as bool,
      onion: fields[8] as bool,
      tomato: fields[9] as bool,
      figiri: fields[10] as bool,
      nuts: fields[11] as bool,
      notes: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DailyLog obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.waterIntake)
      ..writeByte(2)
      ..write(obj.alcohol)
      ..writeByte(3)
      ..write(obj.caffeine)
      ..writeByte(4)
      ..write(obj.chinese)
      ..writeByte(5)
      ..write(obj.mchicha)
      ..writeByte(6)
      ..write(obj.eggs)
      ..writeByte(7)
      ..write(obj.carrot)
      ..writeByte(8)
      ..write(obj.onion)
      ..writeByte(9)
      ..write(obj.tomato)
      ..writeByte(10)
      ..write(obj.figiri)
      ..writeByte(11)
      ..write(obj.nuts)
      ..writeByte(12)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
