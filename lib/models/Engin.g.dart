// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Engin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Engin _$EnginFromJson(Map<String, dynamic> json) => Engin(
      id: json['id'] as int,
      name: json['name'] as String,
      composition: (json['composition'] as List<dynamic>)
          .map((e) => EnginComposition.fromJson(e as Map<String, dynamic>))
          .toList(),
      longueur: json['longueur'] as int,
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      colorHex: json['color'] as String?,
    )..serie = json['serie'] == null
        ? null
        : EnginSerie.fromJson(json['serie'] as Map<String, dynamic>);

Map<String, dynamic> _$EnginToJson(Engin instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.colorHex,
      'longueur': instance.longueur,
      'updated_at': instance.updated_at?.toIso8601String(),
      'composition': instance.composition,
      'serie': instance.serie,
    };
