// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetTokenResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTokenResponse _$GetTokenResponseFromJson(Map<String, dynamic> json) =>
    GetTokenResponse(
      status: json['status'] as String,
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetTokenResponseToJson(GetTokenResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'token': instance.token,
      'message': instance.message,
      'user': instance.user,
    };
