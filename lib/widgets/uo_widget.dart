import 'package:flutter/material.dart';
import 'package:gov/models/UO.dart';

class UO_Widget extends StatelessWidget {
  const UO_Widget(this.uoStatus,{super.key});

  final UO uoStatus;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 1,
            color: Colors.black,
            style: BorderStyle.solid,
          )
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getPart(uoStatus.topLeft),
                      SizedBox(width: 2),
                      getPart(uoStatus.topRight),
                    ]),
                SizedBox(height: 2),
                Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getPart(uoStatus.bottomLeft),
                      SizedBox(width: 2),
                      getPart(uoStatus.bottomRight),
                    ])
              ],
            )));
  }


  Widget getPart(bool isActive)=>Container(
      height: 25,
      width: 25,
      color: isActive?Colors.green:Colors.white);
}
