import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/EnginAtelier.dart';
import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/ROLES.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:gov/widgets/EnginWidget.dart';

class VoieEnginInfoWidget extends StatefulWidget {
  const VoieEnginInfoWidget(this.voieEngin, {super.key});

  @override
  State<VoieEnginInfoWidget> createState() => _VoieEnginInfoWidgetState();

  final VoieEngin voieEngin;
}

class _VoieEnginInfoWidgetState extends State<VoieEnginInfoWidget> {
  EnginAtelier? enginAtelier;

  late final int enginLongour;
  late final bool allowAddingUser;
  late final List<EnginComposition> composition =
      widget.voieEngin.engin!.composition;
  late bool isUserAffecte;
  @override
  void initState() {
    super.initState();

    if (Data.currentUserRole == ROLES.DUO) {
      allowAddingUser = true;
    } else if (Data.currentUserRole == ROLES.DPX) {
      allowAddingUser = true;
    } else {
      allowAddingUser = false;
    }

    Data.getVoieEnginsUsers(widget.voieEngin.id!).then((val) {
      if (Data.currentUserRole == ROLES.DUO) {
        for (var composant in val) {
          composant.userEngins!.removeWhere((userEngin) =>
              (userEngin.status == null || userEngin.status!) &&
              userEngin.user.equipe != null &&
              userEngin.user.equipe!.atelier.duo_id != Data.currentUserID);
        }
      } else if (Data.currentUserRole == ROLES.DPX) {
        for (var composant in val) {
          composant.userEngins!.removeWhere((userEngin) =>
              (userEngin.status == null || userEngin.status!) &&
              userEngin.user.equipe != null &&
              userEngin.user.equipe!.dpx_id != Data.currentUserID);
        }
      } else if (Data.currentUserRole != ROLES.RCI) {
        for (var composant in val) {
          composant.userEngins!.removeWhere((userEngin) =>
              ((userEngin.status == null || userEngin.status == true) &&
                  userEngin.user_id != Data.currentUserID));
        }
      }

      setState(() => widget.voieEngin.engin!.composition = val);
    });

    if (Data.currentUserRole == ROLES.DUO) {
      Data.getEnginAtelierByDUOID(widget.voieEngin.id!)
          .then((value) => setState(() => enginAtelier = value));
    }

    enginLongour = widget.voieEngin.engin!.longueur;
    widget.voieEngin.engin!.longueur = (enginLongour * 2.1).toInt();

    for (int i = 0; i < widget.voieEngin.engin!.composition.length; i++) {
      if (widget.voieEngin.engin!.composition[i].ids_started_work
          .contains(Data.currentUserID)) {
        isUserAffecte = true;
        break;
      }
      isUserAffecte = false;
    }
  }

  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    String? updatedDate;

    if (enginAtelier?.updated_at != null) {
      var updatedAt = enginAtelier!.updated_at!;
      updatedDate = "";
      updatedDate += "Modifier en ${updatedAt.hour}:${updatedAt.minute}";
      updatedDate +=
          " ${updatedAt.day}/${updatedAt.month}/${updatedAt.year % 2000}";
    } else {
      updatedDate = null;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isUserAffecte)
          FilledButton(
            onPressed: () async {
              await Data.addCurrentUserToAllUserEngin(widget.voieEngin, true);
              await reloadDataFromAPI();
            },
            child: const Text("Désaffecter à tous"),
          )
        else
          TextButton(
              onPressed: () =>
                  Data.addCurrentUserToAllUserEngin(widget.voieEngin, false)
                      .then((value) => setState(() {
                            reloadDataFromAPI();
                          })),
              child: const Text("Affecter à tous")),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
                child: EnginWidget(
                    widget.voieEngin.engin!,
                    voieEngin: widget.voieEngin,
                    allowAddingUser: allowAddingUser,
                    setStateParent: () => setState(() {
                          reloadDataFromAPI();
                        }),
                    allowAddingCurrentUser: true,
                    true)),
          ),
        ),
        SizedBox(height: 30),
        if (enginAtelier != null)
          ListTile(
            leading: Text("Atelier"),
            title: Text(enginAtelier!.atelier.name),
            subtitle: updatedDate == null ? null : Text(updatedDate),
            trailing: FilledButton(
              onPressed: () async {
                enginAtelier!.status = !enginAtelier!.status;
                var updateVoieResponse =
                    await Data.updateEnginAtelier(enginAtelier!);
                if (updateVoieResponse.status != "ok") {
                  enginAtelier!.status = !enginAtelier!.status;
                }

                setState(() {});
              },
              child: (!enginAtelier!.status)
                  ? Text("Valider les travaux")
                  : Text("Retirer la validation"),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    for (var element in widget.voieEngin.engin!.composition) {
      element.userEngins = null;
    }
    widget.voieEngin.engin!.longueur = enginLongour;

    super.dispose();
  }

  void isUserAffecteReload(List<EnginComposition> composition) {
    for (int i = 0; i < composition.length; i++) {
      if (composition[i].ids_started_work.contains(Data.currentUserID)) {
        isUserAffecte = true;
      }
    }
    isUserAffecte = false;
  }

  Future<void> reloadDataFromAPI() async {
    var val = await Data.getVoieEnginsUsers(widget.voieEngin.id!);
    if (Data.currentUserRole == ROLES.DUO) {
      for (var composant in val) {
        composant.userEngins!.removeWhere((userEngin) =>
            (userEngin.status == null || userEngin.status!) &&
            userEngin.user.equipe != null &&
            userEngin.user.equipe!.atelier.duo_id != Data.currentUserID);
      }
    } else if (Data.currentUserRole == ROLES.DPX) {
      for (var composant in val) {
        composant.userEngins!.removeWhere((userEngin) =>
            (userEngin.status == null || userEngin.status!) &&
            userEngin.user.equipe != null &&
            userEngin.user.equipe!.dpx_id != Data.currentUserID);
      }
    } else if (Data.currentUserRole != ROLES.RCI) {
      for (var composant in val) {
        composant.userEngins!.removeWhere((userEngin) =>
            ((userEngin.status == null || userEngin.status == true) &&
                userEngin.user_id != Data.currentUserID));
      }
    }

    setState(() {
      widget.voieEngin.engin!.composition = val;

      for (int i = 0; i < widget.voieEngin.engin!.composition.length; i++) {
        if (widget.voieEngin.engin!.composition[i].ids_started_work
            .contains(Data.currentUserID)) {
          isUserAffecte = true;
          break;
        }
        isUserAffecte = false;
      }
    });
  }
}
