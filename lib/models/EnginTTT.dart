import 'dart:math';

import 'package:flutter/material.dart';

import 'EnginCompositionTTTTTTT.dart';

class EnginTT {
  final String name;
  late String type;

  final Color color;

  List<EnginCompositionTTTTTTT> composition;

  Function(int)? onClickComposition;

  EnginTT({
    required this.name,
    this.color = Colors.white,
    required this.composition,
  });

  Widget getWidget({double composWidth=135}) => Row(
      children: List.generate(
          composition.length, (index) {
        var widget = composition[index]
            .getWidget(reverse: composition.length==index+1,composWidth: composWidth);

            return widget;
      }));

  Widget getWidgetSlected(int slectedIndex,{double composWidth=135}) => Row(
      children: List.generate(
          composition.length, (index) {
        final tempColor=composition[index].color;
        composition[index].color=index==slectedIndex? Colors.blueAccent:Colors.grey;
        var widget = composition[index]
            .getWidget(reverse: composition.length==index+1,composWidth: composWidth);

        if(index!=slectedIndex){
          widget=Opacity(opacity: 0.20,child: widget);
        }

        composition[index].color=tempColor;

        return InkWell(child: widget,onTap: ()=>onClickComposition!(index));
      }));
}
