import 'package:gov/models/VoieEngin.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Voie.g.dart';


@JsonSerializable()
class Voie{


   final int id;

  Voie(
      { required this.id,
        required this.longueur,
        required  this.electrifiee,
         this.hors_service=false,
        this.type,
    this.sous_tension=false,
         this.comment="",
         this.created_at,
      this.updated_at,
  required this.VoieEngins});

  int longueur;
  final bool electrifiee;
  bool hors_service;
  bool sous_tension;
  bool? valide_coupure;
  String? type;

  String comment;
   DateTime? created_at;
  DateTime? updated_at;

  List<VoieEngin> VoieEngins;



  factory Voie.fromJson(Map<String, dynamic> json) => _$VoieFromJson(json);
  Map<String, dynamic> toJson() => _$VoieToJson(this);

}