// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personne.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonneAdapter extends TypeAdapter<Personne> {
  @override
  final int typeId = 0;

  @override
  Personne read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Personne(
      id: fields[0] as String?,
      nom: fields[1] as String,
      prenom: fields[2] as String,
      age: (fields[3] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Personne obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.prenom)
      ..writeByte(3)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
