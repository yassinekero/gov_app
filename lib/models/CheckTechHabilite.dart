import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/EnginSerie.dart';
import 'package:json_annotation/json_annotation.dart';

import 'VoieCheckList.dart';

part 'CheckTechHabilite.g.dart';
/*

id, titre, subtitre, order, pour_coupure, status, updated_at
*/


@JsonSerializable()
class CheckTechHabilite {
  final int id;
  final String titre;
  final String subtitre;
  final int order;
  final bool pour_coupure;


  VoieCheckList? voieCheckList;


  bool get status{
    if(voieCheckList==null) {
      return false;
    } else {
      return voieCheckList!.status;
    }
}


  factory CheckTechHabilite.fromJson(Map<String, dynamic> json) => _$CheckTechHabiliteFromJson(json);

  CheckTechHabilite(this.id, this.titre, this.subtitre, this.order, this.pour_coupure);

  Map<String, dynamic> toJson() => _$CheckTechHabiliteToJson(this);
}

