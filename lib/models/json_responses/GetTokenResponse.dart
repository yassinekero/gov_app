import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/User.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GetTokenResponse.g.dart';

@JsonSerializable()
class GetTokenResponse {
  final String status;
  final String? token;
  final String? message;
  final User? user;




  GetTokenResponse({required this.status, this.token,this.user,this.message});


  factory GetTokenResponse.fromJson(Map<String, dynamic> json) => _$GetTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTokenResponseToJson(this);
}