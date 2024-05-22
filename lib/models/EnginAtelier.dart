import 'package:gov/models/Atelier.dart';
import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/EnginSerie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EnginAtelier.g.dart';

/*

    "atelier_id": 2,
                        "voie_engin_id": 1,
                        "comment": "",
                        "created_at": "2023-07-18T09:30:10.102Z",
                        "status": false,
                        "atelier": {

*/
@JsonSerializable()
class EnginAtelier {
  final int atelier_id;
  final int voie_engin_id;

  String comment;
  bool status;

  Atelier atelier;

  @JsonKey(
      includeToJson: false)
  DateTime? updated_at;



  factory EnginAtelier.fromJson(Map<String, dynamic> json) => _$EnginAtelierFromJson(json);

  EnginAtelier(
      {required this.atelier_id,
        required this.voie_engin_id,
        required this.atelier,
        required  this.comment,
        required this.status});

  Map<String, dynamic> toJson() => _$EnginAtelierToJson(this);
}

