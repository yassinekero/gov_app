import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/Utils.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:gov/widgets/EnginAtelierWidget.dart';
import 'package:gov/widgets/EnginWidget.dart';
import 'package:gov/widgets/text_border.dart';
import 'package:gov/widgets/uo_widget.dart';

class VoieEnginWidget extends StatelessWidget {
  const VoieEnginWidget(this.voieEngin,{super.key});

  final VoieEngin voieEngin;
  @override
  Widget build(BuildContext context) {
    var engin = voieEngin.engin!;


    final double minWidth;
    if(Data.isTV ){
      minWidth=min(250, engin.longueur/2).toDouble();
    }else{
      minWidth=engin.longueur.toDouble();
    }

    print('voie ${voieEngin.engin_id} -- ${voieEngin.confirme}');
    return Opacity(
      opacity: voieEngin.confirme ? 1.0 : 0.2,
      child: Flex(direction: Data.isTV ?Axis.horizontal:Axis.vertical,
        children: [
          Container(width: minWidth,
            child: FittedBox(fit: BoxFit.scaleDown,
              child: Row(mainAxisSize: MainAxisSize.min,children: [
                IntrinsicWidth(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        TextBorder(engin.fullName,
                          color: engin.colorHex?.toColor() ?? Colors.white,
                        ),
                        TextBorder(voieEngin.prevision_sortie)
                      ]),
                      TextBorder(voieEngin.motif, width: double.infinity)
                    ])),

                if (voieEngin.estimmobilise)
                  Container(
                    height: 62,
                    width: 62,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1)),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              width: 30, height: 30, color: Colors.red),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              width: 30, height: 30, color: Colors.red),
                        )
                      ],
                    ),
                  ),
                SizedBox(width: 5,),
         //   UO_Widget(widget.voieSide.uoStatus),
                if(voieEngin.enginAteliers!.isNotEmpty)
                EnginAtelierWidget(voieEngin.enginAteliers!),
                if(voieEngin.enginAteliers!.isNotEmpty)
                SizedBox(width: 10),
                Container(
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Expanded(
                              child: TextBorder("BT",
                                  color: voieEngin.basset
                                      ? Colors.red
                                      : Colors.lightGreen)),
                          Expanded(
                              child: TextBorder("HT",
                                  color: voieEngin.hautet
                                      ? Colors.red
                                      : Colors.lightGreen))
                        ]),
                        Row(children: [
                          TextBorder("MT",
                              color: voieEngin.moyennet
                                  ? Colors.red
                                  : Colors.lightGreen),
                          TextBorder("MAT",
                              color: voieEngin.miseaterre
                                  ? Colors.red
                                  : Colors.lightGreen)
                        ]),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )
,
          FittedBox(child: EnginWidget(engin,false))
        ],
      ),
    );
  }
}
