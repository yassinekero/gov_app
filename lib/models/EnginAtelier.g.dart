// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EnginAtelier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnginAtelier _$EnginAtelierFromJson(Map<String, dynamic> json) => EnginAtelier(
      atelier_id: json['atelier_id'] as int,
      voie_engin_id: json['voie_engin_id'] as int,
      atelier: Atelier.fromJson(json['atelier'] as Map<String, dynamic>),
      comment: json['comment'] as String,
      status: json['status'] as bool,
    )..updated_at = json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String);

Map<String, dynamic> _$EnginAtelierToJson(EnginAtelier instance) =>
    <String, dynamic>{
      'atelier_id': instance.atelier_id,
      'voie_engin_id': instance.voie_engin_id,
      'comment': instance.comment,
      'status': instance.status,
      'atelier': instance.atelier,
    };
