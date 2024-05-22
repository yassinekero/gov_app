// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VoieEngin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoieEngin _$VoieEnginFromJson(Map<String, dynamic> json) => VoieEngin(
      id: json['id'] as int?,
      created_at: DateTime.parse(json['created_at'] as String),
      deleted_at: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      motif: json['motif'] as String? ?? "",
      prevision_sortie: json['prevision_sortie'] as String? ?? "",
      comment: json['comment'] as String? ?? "",
      position_voie: json['position_voie'] as int? ?? 0,
      voie_id: json['voie_id'] as int? ?? 0,
      engin_id: json['engin_id'] as int? ?? 0,
      basset: json['basset'] as bool? ?? false,
      coactivite: json['coactivite'] as bool? ?? false,
      estimmobilise: json['estimmobilise'] as bool? ?? false,
      hautet: json['hautet'] as bool? ?? false,
      miseaterre: json['miseaterre'] as bool? ?? false,
      moyennet: json['moyennet'] as bool? ?? false,
      confirme: json['confirme'] as bool? ?? false,
      engin: json['engin'] == null
          ? null
          : Engin.fromJson(json['engin'] as Map<String, dynamic>),
      enginAteliers: (json['enginAteliers'] as List<dynamic>?)
          ?.map((e) => EnginAtelier.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VoieEnginToJson(VoieEngin instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['deleted_at'] = instance.deleted_at?.toIso8601String();
  val['motif'] = instance.motif;
  val['prevision_sortie'] = instance.prevision_sortie;
  val['comment'] = instance.comment;
  val['position_voie'] = instance.position_voie;
  val['voie_id'] = instance.voie_id;
  val['engin_id'] = instance.engin_id;
  val['basset'] = instance.basset;
  val['coactivite'] = instance.coactivite;
  val['estimmobilise'] = instance.estimmobilise;
  val['hautet'] = instance.hautet;
  val['miseaterre'] = instance.miseaterre;
  val['moyennet'] = instance.moyennet;
  val['enginAteliers'] = instance.enginAteliers;
  return val;
}
