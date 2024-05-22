import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/ROLES.dart';
import 'package:gov/models/Voie.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:gov/widgets/AddEnginWidget.dart';
import 'package:gov/widgets/VoieEnginInfoWidget.dart';
import 'package:gov/widgets/VoieEnginWidget.dart';

class AddEnginVoieVideSpaceWidget extends StatelessWidget {
  const AddEnginVoieVideSpaceWidget(this.startIndex, this.width,
      {this.voieEngin, required this.voie, super.key});

  final double startIndex;
  final double width;

  final Voie voie;

  final VoieEngin? voieEngin;

  @override
  Widget build(BuildContext context) {


var textDateCreatedStyle = Theme.of(context).textTheme.titleMedium;

    double spacerWidth = 10;

    final Object Function()? onClick;
    final Object Function()? onLongClick;

    switch (Data.currentUserRole) {
      case ROLES.RCI:
        onClick = voieEngin != null
            ? () => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Row(
                        children: [
                          Text(voieEngin!.created_at_formated,style: textDateCreatedStyle),
                          const Spacer(),
                          Text(voieEngin!.engin!.fullName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          Spacer(),
                          Text(voieEngin!.prevision_sortie.padLeft(
                              voieEngin!.created_at_formated.length-
                                  voieEngin!.prevision_sortie.length," "),style: textDateCreatedStyle),
                        ],
                      ),
                      content: VoieEnginInfoWidget(voieEngin!)),
                )
            :
                    () {
          print('hey');
          if(Data.tempVE != null){
            print('not empty');
            Data.tempVE!.voie_id = voie.id!;
           return showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                  title: Text("Modifier l'engin",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  content: AddEditEnginWidget(
                    voieEnginToEdit: Data.tempVE,
                    voie,
                    minPos: startIndex,
                    maxPos: startIndex + width + spacerWidth,
                  )),
            );
          }else{
            print('empty');
           return showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                  title: Text("Ajouter un engin",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  content: AddEditEnginWidget(
                    voie,
                    minPos: startIndex,
                    maxPos: startIndex + width,
                  )),
            );
          }

                    }

            //.then((value) => setState(() => {}))
                ;

        onLongClick = voieEngin != null
            ? () => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text("Modifier l'engin",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      content: AddEditEnginWidget(
                        voieEnginToEdit: voieEngin,
                        voie,
                        minPos: startIndex,
                        maxPos: startIndex + width + spacerWidth,
                      )),
                )
            : () => {};

        break;
      case ROLES.DUO:
        onClick = voieEngin != null
            ? () => showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(voieEngin!.engin!.fullName,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    content: VoieEnginInfoWidget(voieEngin!),
                  ),
                )
            : null;
        onLongClick = null;

        break;

      case ROLES.DPX:
        onClick = voieEngin != null
            ? () => showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(voieEngin!.engin!.fullName,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    content: VoieEnginInfoWidget(voieEngin!),
                  ),
                )
            : null;
        onLongClick = null;
        break;
      case ROLES.TECH:
        onClick = voieEngin != null
            ? () => showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => AlertDialog(
            title: Text(voieEngin!.engin!.fullName,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            content: VoieEnginInfoWidget(voieEngin!),
          ),
        )
            : null;
        onLongClick = null;

        break;


      case ROLES.TECH_HABILITE:
      case ROLES.AFF:
        onClick = null;
        onLongClick = null;

        break;

      case ROLES.ADMIN:
        onClick = null;
        onLongClick = null;
        break;
    }

    return Positioned(
        bottom: 0,
        left: startIndex + spacerWidth / 2,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          InkWell(
              onLongPress: onLongClick,
              onTap: onClick,
              child: Column(
                children: [
                  if (voieEngin == null)
                    SizedBox(height: 100)
                  else
                    VoieEnginWidget(voieEngin!),
                  Container(
                      height: 5, width: width - spacerWidth, color: Colors.blue)
                ],
              )),
          Text("${startIndex + width}m",
              style: Theme.of(context).textTheme.labelSmall)
        ]));
  }
}

/*
Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () => {},
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 80,
                                                  child: EnginWidget(
                                                      voie.VoieEngins[i].engin),
                                                ),
                                                Container(
                                                  height: 5,
                                                  width: voie.VoieEngins[i]
                                                      .engin.longueur
                                                      .toDouble(),
                                                  color: Colors.blueAccent,
                                                )
                                              ],
                                            )),
                                        Text(
                                          (voie.VoieEngins[i].position_voie +
                                                      voie.VoieEngins[i].engin
                                                          .longueur)
                                                  .toString() +
                                              "m",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        )
                                      ])
* */
