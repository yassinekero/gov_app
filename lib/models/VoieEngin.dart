

import 'package:gov/models/Engin.dart';
import 'package:gov/models/EnginAtelier.dart';
import 'package:json_annotation/json_annotation.dart';

part 'VoieEngin.g.dart';
@JsonSerializable()
class VoieEngin{
  @JsonKey(includeIfNull: false)
  final int? id;

  VoieEngin(
      {this.id,
         required this.created_at,
          this.deleted_at,
         this.motif="",
          this.prevision_sortie="",
         this.comment="",
         this.position_voie=0,  this.voie_id=0,  this.engin_id=0,
         this.basset=false,
          this.coactivite=false,
          this.estimmobilise=false,
         this.hautet=false,
         this.miseaterre=false,
         this.moyennet=false,
        this.confirme=false,
   this.engin,
        this.enginAteliers});


  @JsonKey(
      includeToJson: false,includeIfNull: false)
  DateTime created_at;
  @JsonKey(
      includeToJson: false)

  @JsonKey(
      includeToJson: false,includeFromJson: false)
  String get  created_at_formated{
    print(created_at.toString());
    DateTime today = created_at;
    String dateFormated ="${today.year.toString().substring(2,)}"
        "-${today.month.toString().padLeft(2,'0')}"
        "-${today.day.toString().padLeft(2,'0')}"
    "  ${today.hour.toString().padLeft(2,'0')}:"
    " ${today.minute.toString().padLeft(2,'0')}";

  return dateFormated;
}


  DateTime? deleted_at;
  String motif;
  String prevision_sortie;
  String comment;
  int position_voie;
  int voie_id;
  int engin_id;
  bool basset;
  bool coactivite;
  bool estimmobilise;
  bool hautet;
  bool miseaterre;
  bool moyennet;
  bool confirme;

  List<EnginAtelier>? enginAteliers;


  @JsonKey(
      includeToJson: false)
  Engin? engin;


  factory VoieEngin.fromJson(Map<String, dynamic> json) => _$VoieEnginFromJson(json);
  Map<String, dynamic> toJson() => _$VoieEnginToJson(this);

}

/*
json.remove("created_at");
    json.remove("deleted_at");
    json.remove("id");
    json.remove("engin");
* */