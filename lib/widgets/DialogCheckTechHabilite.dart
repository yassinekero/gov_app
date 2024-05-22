import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/CheckTechHabilite.dart';
import 'package:gov/models/ROLES.dart';
import 'package:gov/models/Voie.dart';
import 'package:gov/models/VoieCheckList.dart';

class DialogCheckTechHabilite extends StatefulWidget {
  const DialogCheckTechHabilite(this.voie, {super.key});

  @override
  State<DialogCheckTechHabilite> createState() =>
      _DialogCheckTechHabiliteState();

  final Voie voie;
}

class _DialogCheckTechHabiliteState extends State<DialogCheckTechHabilite> {
  List<CheckTechHabilite> listCheckHabilite = [];

  late final int isCoupure;
  late final bool allowEditing;

  @override
  void initState() {
    isCoupure = widget.voie.sous_tension ? 1 : 0;

    allowEditing = (Data.currentUserRole == ROLES.TECH_HABILITE);

    Data.getListCheckTechHabilite(isCoupure, widget.voie.id!)
        .then((value) => setState(() => listCheckHabilite = value));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool allValide = true;

    listCheckHabilite.forEachWhile((element) {
      if (!element.status) {
        allValide = false;
        return false;
      }
      return true;
    });

    return Container(
      width: 600,
      child: SingleChildScrollView(
        child: Column(children: [
          for (int i = 0; i < listCheckHabilite.length; i++)
            checkHabWidget(listCheckHabilite[i], i),
          if( allowEditing)
          SizedBox(height: 25),
          if( allowEditing)
          FilledButton(
              onPressed: !allValide ||
                      widget.voie.valide_coupure != null
                  ? null
                  : () {
                      widget.voie.valide_coupure = isCoupure == 1;
                      Data.updateVoie(widget.voie).then((value) {
                        if (value.status == "ok") {
                        } else {
                          widget.voie.valide_coupure = null;
                        }

                        setState(() => {});
                      });
                    },
              child: Text(
                widget.voie.valide_coupure == null
                    ? "Valider ${isCoupure == 1 ? 'la coupure' : 'l\'établissement'} du courant"
                    : "Bien validée",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ))
        ]),
      ),
    );
  }

  Widget checkHabWidget(CheckTechHabilite checkHab, int i) {
    final bool enable;

    if (allowEditing) {
      if (widget.voie.valide_coupure != null) {
        enable = false;
      } else if (i > 0) {
        enable = listCheckHabilite[i - 1].status;
      } else {
        enable = true;
      }
    } else
      enable = false;
    print("darai ${checkHab.status} ${checkHab.id}");

    return CheckboxListTile(
        enabled: enable,
        secondary: Text(checkHab.order.toString()),
        value: checkHab.status,
        onChanged: (b) {
          checkHab.voieCheckList ??= VoieCheckList(checkHab.id, widget.voie.id!);

          setState(() => checkHab.voieCheckList!.status = b!);
          Data.updateVoieCheckListStatus(
              checkHab.id, widget.voie.id!, checkHab.status ? 1 : 0);
        },
        title: Text(checkHab.titre),
        subtitle: Text(checkHab.subtitre));
  }
}
