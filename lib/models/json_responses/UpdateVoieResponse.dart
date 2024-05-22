import 'package:gov/models/Engin.dart';
import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/Voie.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UpdateVoieResponse.g.dart';

@JsonSerializable()
class UpdateVoieResponse {
  final String status;


  //Voie? voie;
  String? message;

  UpdateVoieResponse(this.status);


  factory UpdateVoieResponse.fromJson(Map<String, dynamic> json) => _$UpdateVoieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateVoieResponseToJson(this);
}