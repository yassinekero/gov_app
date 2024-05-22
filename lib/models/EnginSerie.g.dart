// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EnginSerie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnginSerie _$EnginSerieFromJson(Map<String, dynamic> json) => EnginSerie(
      json['id'] as int?,
      json['name'] as String,
    )..freeEngins = (json['freeEngins'] as List<dynamic>?)
        ?.map((e) => Engin.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$EnginSerieToJson(EnginSerie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'freeEngins': instance.freeEngins,
    };
