import 'package:gov/models/Atelier.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Equipe.g.dart';


@JsonSerializable()
class Equipe{


  int? id;


  Equipe({this.id, required this.name, required this.dpx_id, required this.atelier_id, required this.atelier});

  String name;
  int dpx_id;
  int atelier_id;

  Atelier atelier;




  factory Equipe.fromJson(Map<String, dynamic> json) => _$EquipeFromJson(json);
  Map<String, dynamic> toJson() => _$EquipeToJson(this);

}