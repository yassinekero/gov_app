// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AssignEnginResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignEnginResponse _$AssignEnginResponseFromJson(Map<String, dynamic> json) =>
    AssignEnginResponse(
      json['status'] as String,
    )
      ..voieEngin = json['voieEngin'] == null
          ? null
          : VoieEngin.fromJson(json['voieEngin'] as Map<String, dynamic>)
      ..message = json['message'] as String?;

Map<String, dynamic> _$AssignEnginResponseToJson(
        AssignEnginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'voieEngin': instance.voieEngin,
      'message': instance.message,
    };
