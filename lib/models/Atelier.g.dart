// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Atelier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Atelier _$AtelierFromJson(Map<String, dynamic> json) => Atelier(
      id: json['id'] as int,
      name: json['name'] as String,
      duo_id: json['duo_id'] as int,
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AtelierToJson(Atelier instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'duo_id': instance.duo_id,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
