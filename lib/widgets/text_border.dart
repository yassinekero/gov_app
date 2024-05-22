import 'package:flutter/material.dart';

class TextBorder extends StatelessWidget {
  const TextBorder(this.text, {this.width,this.color, super.key});

  final String text;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(top: 5, right: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Text(
        text,
        textAlign: TextAlign.center
      ),
      decoration: BoxDecoration(border: Border.all(color: Colors.black),color: color,),
    );
  }
}
