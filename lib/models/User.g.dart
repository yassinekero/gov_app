// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      matricule: json['matricule'] as String,
      name: json['name'] as String,
      img: json['img'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      equipe_id: json['equipe_id'] as int?,
      role_key: json['role_key'] as String,
      role: json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>),
    )..equipe = json['equipe'] == null
        ? null
        : Equipe.fromJson(json['equipe'] as Map<String, dynamic>);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'matricule': instance.matricule,
      'name': instance.name,
      'img': instance.img,
      'email': instance.email,
      'phone': instance.phone,
      'role': instance.role,
      'password': instance.password,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'equipe_id': instance.equipe_id,
      'equipe': instance.equipe,
      'role_key': instance.role_key,
    };
