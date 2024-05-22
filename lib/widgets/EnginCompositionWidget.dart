import 'dart:math';

import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically
import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/ROLES.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:gov/widgets/UserEnginWidget.dart';
import 'package:gov/widgets/add_person_aff_widget.dart';

class EnginCompositionWidget extends StatefulWidget {
  EnginCompositionWidget(this.enginComposition,
      {required this.width,
      this.reverse = false,
      this.voieEngin,
      this.allowAddingUsers = false,
      this.allowCureentAffectation = false,
      this.setStateParent,
      super.key});

  final EnginComposition enginComposition;
  final bool reverse;

  final double width;
  final bool allowCureentAffectation;

  final VoieEngin? voieEngin;
  final bool allowAddingUsers;

  final void Function()? setStateParent;

  @override
  State<EnginCompositionWidget> createState() => _EnginCompositionWidgetState();
}

class _EnginCompositionWidgetState extends State<EnginCompositionWidget> {
  @override
  Widget build(BuildContext context) {
    var enginComposition = widget.enginComposition;

    final Color color;
    if (enginComposition.nb_started_work > 0) {
      color = Colors.red;
    }

    /*else if (enginComposition.nb_assigned_not_started > 0) {
      color = Colors.purpleAccent;
    } */

    else if (widget.enginComposition.nb_assigned_not_started == 0 &&
        widget.enginComposition.nb_started_work == 0 &&
        widget.enginComposition.nb_finished_work > 0) {
      color = Colors.lightGreen;
    } else {
      color = Colors.white;
    }

    final String path =
        widget.enginComposition.type == "M" ? "motrice.png" : "voiture.png";

    Widget imageWidget = Image.asset(
      "assets/images/$path",
      fit: BoxFit.fitWidth,
    );

    imageWidget = widget.reverse
        ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: imageWidget,
          )
        : imageWidget;

    return Column(
      children: [
          if (widget.allowCureentAffectation)
        SizedBox(
          height: 10,
        ),
        if (widget.allowCureentAffectation)
          if (enginComposition.ids_started_work.contains(Data.currentUserID))
            FilledButton(
                onPressed: () => Data.addCurrentUserToUserEngin(
                        widget.voieEngin!.id!, widget.enginComposition.id, true)
                    .then((value) => setState(() {
                          if (value.status == "ok") {
                            enginComposition.ids_finished_work
                                .add(Data.currentUserID);
                            // enginComposition.ids_started_work
                            //     .remove(Data.currentUserID);
                          }
                          reloadDataFromAPI();
                        })),
                child: const Text("Désaffecter"))
          else
            TextButton(
                onPressed: () {
                  var userEngin = widget.enginComposition.userEngins!
                      .firstWhereOrNull((userEngin) =>
                          userEngin.user_id == Data.currentUserID &&
                          (userEngin.composition_id ==
                              widget.enginComposition.id));

                  // if (userEngin != null && userEngin.tache.isNotEmpty) {
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) => AlertDialog(
                  //       title: const Text(
                  //         "Tache",
                  //         style: TextStyle(
                  //             color: Colors.black, fontWeight: FontWeight.bold),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //       content: Text(
                  //         userEngin.tache,
                  //         style: Theme.of(context).textTheme.bodyMedium,
                  //       ),
                  //     ),
                  //   );
                  // }

                  Data.addCurrentUserToUserEngin(widget.voieEngin!.id!,
                          widget.enginComposition.id, false)
                      .then((value) => setState(() {
                            if (value.status == "ok") {
                            
                              // enginComposition.ids_assigned_users
                              //     .remove(Data.currentUserID);
                              enginComposition.ids_started_work
                                  .add(Data.currentUserID);
                            }
                              reloadDataFromAPI();
                          }));
                },
                child: const Text("S'affecter")),
        SizedBox(
            width: widget.width,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: widget.width,
                          color: color,
                          child: imageWidget),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: FittedBox(
                              child: Text(
                            widget.enginComposition.name.isEmpty
                                ? " "
                                : widget.enginComposition.name.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      if (widget.enginComposition.userEngins != null)
                        ...widget.enginComposition.userEngins!.map(
                            (userEngin) => UserEnginWidget(userEngin,
                                deleteFunction: () => setState(() => widget
                                    .enginComposition.userEngins!
                                    .remove(userEngin)))),
                      if (widget.allowAddingUsers)
                        //   if (widget.voieEngin != null)
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder()),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      "Affecter des personnes",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    content: AddPersonAffecWidget(
                                        widget.voieEngin!.id!,
                                        widget.enginComposition),
                                  ),
                                ).then((value) {
                                  bool? valBol = value;
                                  if (valBol ?? false) {
                                    reloadDataFromAPI();
                                  }
                                });
                              },
                              child: Container(
                                  width: double.infinity,
                                  child: const Icon(Icons.add))),
                        )
                    ],
                  ),
                ),
                if (widget.enginComposition.nb_started_work > 0)
                  Positioned.fill(
                    top: 5,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                          maxRadius: 13,
                          backgroundColor: Colors.yellow,
                          child: Text(
                            widget.enginComposition.nb_started_work.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                if (widget.enginComposition.ids_assigned_users
                    .contains(Data.currentUserID))
                  const Positioned.fill(
                    top: 1,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Icon(color: Colors.red, Icons.error)),
                  ),
              ],
            )),
      ],
    );
  }

  void reloadDataFromAPI() {
    /*Data.getVoieEnginsUsers(widget.voieEngin!.id!).then((composants) {
      var enginComposition =
          composants.firstWhere((cmp) => cmp.id == widget.enginComposition.id);

      if (Data.currentUserRole == ROLES.DUO) {

        enginComposition.userEngins!.removeWhere((userEngin) =>
            (userEngin.status == null || userEngin.status!) &&
            userEngin.user.equipe != null &&
            userEngin.user.equipe!.atelier.duo_id != Data.currentUserID);

      } else if (Data.currentUserRole == ROLES.DPX) {

        enginComposition.userEngins!.removeWhere((userEngin) =>
            (userEngin.status == null || userEngin.status!) &&
            userEngin.user.equipe != null &&
            userEngin.user.equipe!.dpx_id != Data.currentUserID);

      } else {

        enginComposition.userEngins!.removeWhere((userEngin) =>
            ((userEngin.status == null || userEngin.status == true) &&
                userEngin.user_id != Data.currentUserID));

      }

      setState(() =>
          widget.enginComposition.userEngins = enginComposition.userEngins);
    });
    */

    Data.getVoieEnginsUsers(widget.voieEngin!.id!).then((val) {
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

     
      widget.voieEngin!.engin!.composition = val;
      //  setState(() => widget.voieEngin!.engin!.composition = val);

      widget.setStateParent!();
    });
  }
}
