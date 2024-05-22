import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gov/models/EnginAtelier.dart';

class EnginAtelierWidget extends StatelessWidget {
  EnginAtelierWidget(this.enginAteliers, {super.key});

  final List<EnginAtelier> enginAteliers;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ...buildAteliersWidgets(),
          ...buildTexts()
        ],
      ),
    );
  }

  List<Widget> buildTexts() {
    final int nbAteliers = enginAteliers.length;
    var sep = <Widget>[];
    for (var i = 0; i < nbAteliers; i++) {
      sep.add(
        Transform.rotate(
          angle: i * 2 * pi / nbAteliers + pi / nbAteliers,
          child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Text(
                enginAteliers[i].atelier.name.substring(0,1).toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
        ),
      );
    }
    return sep;
  }

  List<Widget> buildAteliersWidgets() {
    final int nbAteliers = enginAteliers.length;
    var sep = <Widget>[];
    for (var i = 0; i < nbAteliers; i++) {
      sep.add(
        CustomPaint(
          painter: OpenPainter(
              startAngle: -pi / 2 + i * 2 * pi / (nbAteliers),
              angle: 2 * pi / nbAteliers,
              enginAtelier: enginAteliers[i],
              addDivider: nbAteliers > 1),
          child: Container(
            height: 60,
            width: 60,
          ),
        ),
      );
    }
    return sep;
  }
}

class OpenPainter extends CustomPainter {
  final double startAngle;
  final double angle;
  final EnginAtelier enginAtelier;
  final bool addDivider;

  OpenPainter(
      {required this.startAngle,
      required this.angle,
      required this.enginAtelier,
      this.addDivider = false});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint();

    if (enginAtelier.status) {
      paint1
        ..style = PaintingStyle.fill
        ..color = Colors.lightGreenAccent;
    } else {
      paint1
        ..style = PaintingStyle.fill
        ..strokeWidth = 4
        ..color = Colors.black12;
    }

    //draw arc

    canvas.drawArc(
        const Offset(0, 0) & size,
        startAngle, //radians
        angle, //radians
        true,
        paint1);

    if (addDivider) {
      final paint2 = Paint();
      paint2
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = Colors.white;

      canvas.drawArc(
          const Offset(0, 0) & size,
          startAngle, //radians
          angle, //radians
          true,
          paint2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
