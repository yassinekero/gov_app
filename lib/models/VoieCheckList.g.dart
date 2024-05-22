// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VoieCheckList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoieCheckList _$VoieCheckListFromJson(Map<String, dynamic> json) =>
    VoieCheckList(
      json['check_tech_habilite_id'] as int,
      json['voie_id'] as int,
    )
      ..status = json['status'] as bool
      ..updated_at = json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String);

Map<String, dynamic> _$VoieCheckListToJson(VoieCheckList instance) =>
    <String, dynamic>{
      'check_tech_habilite_id': instance.check_tech_habilite_id,
      'voie_id': instance.voie_id,
      'status': instance.status,
      'updated_at': instance.updated_at?.toIso8601String(),
    };
