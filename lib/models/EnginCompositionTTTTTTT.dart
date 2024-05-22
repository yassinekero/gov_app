import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gov/models/Person.dart';

class EnginCompositionTTTTTTT {
  final bool isMotrice;
  final String identifient;
   Color color;

  List<Person> listPersonAffc;

  EnginCompositionTTTTTTT(
      {required this.isMotrice,
      required this.identifient,
      required this.color, this.listPersonAffc=const []});

  Widget getWidget({bool reverse=false, required double composWidth}) {

    final String path=isMotrice?"motrice.png":"voiture.png";

    Widget imageWidget = Image.asset("assets/images/$path");

    imageWidget= reverse?
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: imageWidget,
        ):imageWidget;

    return Container(
        width: composWidth,
        child: Stack(
          children: [

            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(color: color,child: imageWidget),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    child: FittedBox(child: Text(identifient,style: TextStyle(fontWeight: FontWeight.bold),)),
                  )

                ],
              ),
            ),


            if(listPersonAffc.isNotEmpty)
            Positioned.fill(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(maxRadius: 15,backgroundColor: Colors.yellow,child: Text(listPersonAffc.length.toString()),)),
            ),
          ],
        ));
  }
}
