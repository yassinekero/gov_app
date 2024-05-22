// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EnginComposition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnginComposition _$EnginCompositionFromJson(Map<String, dynamic> json) =>
    EnginComposition(
      json['id'] as int,
      json['name'] as String,
      json['type'] as String,
      userEngins: (json['userEngins'] as List<dynamic>?)
          ?.map((e) => UserEngin.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..nb_assigned_not_started = json['nb_assigned_not_started'] as int
      ..nb_started_work = json['nb_started_work'] as int
      ..nb_finished_work = json['nb_finished_work'] as int
      ..ids_assigned_users = (json['ids_assigned_users'] as List<dynamic>)
          .map((e) => e as int)
          .toList()
      ..ids_started_work = (json['ids_started_work'] as List<dynamic>)
          .map((e) => e as int)
          .toList()
      ..ids_finished_work = (json['ids_finished_work'] as List<dynamic>)
          .map((e) => e as int)
          .toList();

Map<String, dynamic> _$EnginCompositionToJson(EnginComposition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': "${instance.name}",
      'type': "${instance.type}",
    };
