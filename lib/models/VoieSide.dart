import 'package:gov/models/EnginTTT.dart';
import 'package:gov/models/PersonAffecttion.dart';
import 'package:gov/models/TensionStatus.dart';
import 'package:gov/models/UO.dart';
import 'package:gov/models/VoieTTTTT.dart';

class VoieSide {
  UO uoStatus;
  TensionStatus tensionStatus;

  EnginTT? engin;

  String motif;
  String sortirDate;
  bool estimmobilise;

  VoieSide(
      {required this.uoStatus,
      required this.tensionStatus,
      this.engin,
      required this.motif,
      required this.estimmobilise,
      required this.sortirDate});
}
