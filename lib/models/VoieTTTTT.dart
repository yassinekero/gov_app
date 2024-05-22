import 'package:gov/models/UO.dart';
import 'package:gov/models/VoieSide.dart';

class VoieTTTT {
  int identifiant;
  bool electrifiee;
  bool hors_service;
  bool sous_tension;


  VoieSide? leftSide;
  VoieSide? rightSide;





  VoieTTTT(
      this.identifiant, this.electrifiee, this.hors_service, this.sous_tension,
      { this.leftSide,  this.rightSide});

  /*factory Voie.fromJson(dynamic json) {
    return Voie(
      json['id_voie'],
      json['electrifiee'],
      json['hors_service'],
      json['sous_tension'],
    );
  }
*/
  @override
  String toString() {
    return '{ "identifiant": "$identifiant",'
        '"electrifiee": $electrifiee,'
        '"horsService": $hors_service,'
        '"sousTension": $sous_tension}';
  }
}
