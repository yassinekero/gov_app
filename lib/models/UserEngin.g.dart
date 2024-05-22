// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserEngin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEngin _$UserEnginFromJson(Map<String, dynamic> json) => UserEngin(
      id: json['id'] as int,
      voie_engin_id: json['voie_engin_id'] as int,
      user_id: json['user_id'] as int,
      tache: json['tache'] as String,
      composition_id: json['composition_id'] as int,
      status: json['status'] as bool?,
      created_at: DateTime.parse(json['created_at'] as String),
      deleted_at: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserEnginToJson(UserEngin instance) => <String, dynamic>{
      'id': instance.id,
      'voie_engin_id': instance.voie_engin_id,
      'user_id': instance.user_id,
      'tache': instance.tache,
      'composition_id': instance.composition_id,
      'status': instance.status,
      'created_at': instance.created_at.toIso8601String(),
      'deleted_at': instance.deleted_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'user': instance.user,
    };
