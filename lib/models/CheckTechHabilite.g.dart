// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckTechHabilite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckTechHabilite _$CheckTechHabiliteFromJson(Map<String, dynamic> json) =>
    CheckTechHabilite(
      json['id'] as int,
      json['titre'] as String,
      json['subtitre'] as String,
      json['order'] as int,
      json['pour_coupure'] as bool,
    )..voieCheckList = json['voieCheckList'] == null
        ? null
        : VoieCheckList.fromJson(json['voieCheckList'] as Map<String, dynamic>);

Map<String, dynamic> _$CheckTechHabiliteToJson(CheckTechHabilite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'subtitre': instance.subtitre,
      'order': instance.order,
      'pour_coupure': instance.pour_coupure,
      'voieCheckList': instance.voieCheckList,
    };
