// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Voie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voie _$VoieFromJson(Map<String, dynamic> json) => Voie(
      id: json['id'] as int,
      longueur: json['longueur'] as int,
      electrifiee: json['electrifiee'] as bool? ?? false,
      hors_service: json['hors_service'] as bool? ?? false,
      sous_tension: json['sous_tension'] as bool? ?? false,
      comment: json['comment'] as String? ?? "",
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      VoieEngins: (json['VoieEngins'] as List<dynamic>)
          .map((e) => VoieEngin.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..valide_coupure = json['valide_coupure'] as bool?
      ..type = json['type'] as String?;

Map<String, dynamic> _$VoieToJson(Voie instance) => <String, dynamic>{
      'id': instance.id,
      'longueur': instance.longueur,
      'electrifiee': instance.electrifiee,
      'hors_service': instance.hors_service,
      'sous_tension': instance.sous_tension,
      'valide_coupure': instance.valide_coupure,
      'type': instance.type,
      'comment': instance.comment,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'VoieEngins': instance.VoieEngins,
    };
