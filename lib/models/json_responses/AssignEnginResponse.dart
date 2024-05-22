import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AssignEnginResponse.g.dart';

@JsonSerializable()
class AssignEnginResponse {
  final String status;


  VoieEngin? voieEngin;
  String? message;

  AssignEnginResponse(this.status);


  factory AssignEnginResponse.fromJson(Map<String, dynamic> json) => _$AssignEnginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssignEnginResponseToJson(this);
}