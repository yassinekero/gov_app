import 'package:gov/models/Engin.dart';
import 'package:gov/models/EnginComposition.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EnginSerie.g.dart';

@JsonSerializable()
class EnginSerie {
  final int? id;
  String name;

  List<Engin>? freeEngins;

  EnginSerie(this.id,this.name);



  factory EnginSerie.fromJson(Map<String, dynamic> json) => _$EnginSerieFromJson(json);


  Map<String, dynamic> toJson() => _$EnginSerieToJson(this);
}
