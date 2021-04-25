// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriorityAdapter extends TypeAdapter<Priority> {
  @override
  final int typeId = 1;

  @override
  Priority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Priority.LOW;
      case 1:
        return Priority.MEDIUM;
      case 2:
        return Priority.HIGH;
      default:
        return Priority.LOW;
    }
  }

  @override
  void write(BinaryWriter writer, Priority obj) {
    switch (obj) {
      case Priority.LOW:
        writer.writeByte(0);
        break;
      case Priority.MEDIUM:
        writer.writeByte(1);
        break;
      case Priority.HIGH:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      title: fields[0] as String,
      description: fields[1] as String,
      createDate: fields[2] as DateTime,
      modifiedDate: fields[3] as DateTime,
      priority: fields[4] as Priority,
      isDone: fields[6] as bool,
      imageURL: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.createDate)
      ..writeByte(3)
      ..write(obj.modifiedDate)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.imageURL)
      ..writeByte(6)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
