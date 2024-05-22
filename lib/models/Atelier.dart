import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/EnginSerie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Atelier.g.dart';
/*

"id": 2,
                            "name": "MECA",
                            "duo_id": 3,
                            "created_at": "2023-07-12T17:35:56.000Z",
                            "updated_at": null
*/


@JsonSerializable()
class Atelier {
   int? id;


  Atelier({this.id, required this.name,required  this.duo_id,required  this.created_at, this.updated_at});

  String name;

  int duo_id;

  DateTime created_at;
  DateTime? updated_at;








  factory Atelier.fromJson(Map<String, dynamic> json) => _$AtelierFromJson(json);

  Map<String, dynamic> toJson() => _$AtelierToJson(this);
}

