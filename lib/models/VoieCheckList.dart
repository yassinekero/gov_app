import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/EnginSerie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'VoieCheckList.g.dart';
/*

id, titre, subtitre, order, pour_coupure, status, updated_at
*/


@JsonSerializable()
class VoieCheckList {
  final int check_tech_habilite_id;
  final int voie_id;
  bool status=false;

  DateTime? updated_at;



  factory VoieCheckList.fromJson(Map<String, dynamic> json) => _$VoieCheckListFromJson(json);

  VoieCheckList(this.check_tech_habilite_id, this.voie_id);

  Map<String, dynamic> toJson() => _$VoieCheckListToJson(this);
}

