// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Equipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Equipe _$EquipeFromJson(Map<String, dynamic> json) => Equipe(
      id: json['id'] as int,
      name: json['name'] as String,
      dpx_id: json['dpx_id'] as int,
      atelier_id: json['atelier_id'] as int,
      atelier: Atelier.fromJson(json['atelier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EquipeToJson(Equipe instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dpx_id': instance.dpx_id,
      'atelier_id': instance.atelier_id,
      'atelier': instance.atelier,
    };
