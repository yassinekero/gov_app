// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddEnginResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEnginResponse _$CreateEnginResponseFromJson(Map<String, dynamic> json) =>
    CreateEnginResponse(
      json['status'] as String,
    )
      ..engin = json['engin'] == null
          ? null
          : Engin.fromJson(json['engin'] as Map<String, dynamic>)
      ..message = json['message'] as String?;

Map<String, dynamic> _$CreateEnginResponseToJson(
        CreateEnginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'engin': instance.engin,
      'message': instance.message,
    };
