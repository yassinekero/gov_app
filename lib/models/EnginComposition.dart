
import 'package:gov/models/UserEngin.dart';
import 'package:json_annotation/json_annotation.dart';
part 'EnginComposition.g.dart';
@JsonSerializable()
class EnginComposition{
  final int  id;

  EnginComposition(this.id, this.name, this.type,{this.userEngins});

  String name;
  String type;

  @JsonKey(includeToJson: false)
  int nb_assigned_not_started=-1;
  @JsonKey(includeToJson: false)
  int nb_started_work=-1;
  @JsonKey(includeToJson: false)
  int nb_finished_work=-1;

  @JsonKey(includeToJson: false)
  List<UserEngin>? userEngins;
  @JsonKey(includeToJson: false)
  List<int> ids_assigned_users=[];
  @JsonKey(includeToJson: false)
  List<int> ids_started_work=[];
  @JsonKey(includeToJson: false)
  List<int> ids_finished_work=[];

  factory EnginComposition.fromJson(Map<String, dynamic> json) => _$EnginCompositionFromJson(json);
  Map<String, dynamic> toJson() => _$EnginCompositionToJson(this);

}