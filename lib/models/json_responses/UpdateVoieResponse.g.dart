// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UpdateVoieResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateVoieResponse _$UpdateVoieResponseFromJson(Map<String, dynamic> json) =>
    UpdateVoieResponse(
      json['status'] as String,
    )..message = json['message'] as String?;

Map<String, dynamic> _$UpdateVoieResponseToJson(UpdateVoieResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
