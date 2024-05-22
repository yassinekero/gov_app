import 'package:gov/models/Engin.dart';
import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AddEnginResponse.g.dart';

@JsonSerializable()
class CreateEnginResponse {
  final String status;


  Engin? engin;
  String? message;

  CreateEnginResponse(this.status);


  factory CreateEnginResponse.fromJson(Map<String, dynamic> json) => _$CreateEnginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateEnginResponseToJson(this);
}