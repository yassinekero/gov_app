import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/EnginSerie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Engin.g.dart';

@JsonSerializable()
class Engin {
  final int id;

  Engin(
      {required this.id,
      required this.name,
      required this.composition,
      required this.longueur,
      this.updated_at,this.colorHex});

  String name;
  @JsonKey(name: "color")
  String? colorHex;

  int longueur;
  DateTime? updated_at;

  List<EnginComposition> composition;

  EnginSerie? serie;

  @JsonKey(includeFromJson: false,
      includeToJson: false)
  String get fullName{
    String fullName="";
    if(serie==null){
      fullName ="Rame-$name";
    }else {
      fullName ="${serie!.name}-$name";
    }

    return fullName;
  }
  @JsonKey(includeFromJson: false,
      includeToJson: false)
  String get getSerieName{
    return serie?.name??"Rame";
  }




  factory Engin.fromJson(Map<String, dynamic> json) => _$EnginFromJson(json);

  Map<String, dynamic> toJson() => _$EnginToJson(this);
}

