import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/Engin.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:gov/widgets/EnginCompositionWidget.dart';

class EnginWidget extends StatefulWidget {
  const EnginWidget(
    this.engin,
    this.b, {
    super.key,
    this.allowAddingUser = false,
    this.voieEngin,
    this.setStateParent,
    this.allowAddingCurrentUser = false,
  });

  final VoieEngin? voieEngin;
  final bool allowAddingUser;
  final bool allowAddingCurrentUser;
  final Engin engin;
  final bool b;
  final void Function()? setStateParent;

  @override
  State<EnginWidget> createState() => _EnginWidgetState();
}

class _EnginWidgetState extends State<EnginWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final composition = widget.engin.composition;
    final maxWidth;

    if (Data.isTV) {
      maxWidth = max(widget.engin.longueur - 260, widget.engin.longueur / 2)
          .toDouble();
    } else {
      if (widget.b) {
        maxWidth = MediaQuery.of(context).size.width * 0.8;
      } else {
        maxWidth = widget.engin.longueur;
      }
    }

    final compoWidth = (maxWidth / (composition.length));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(composition.length, (i) {
        var isLast = composition.length == i + 1;

        return EnginCompositionWidget(
          setStateParent: () => setState(() {
            reloadData();
           }),
          composition[i],
          reverse: isLast,
          width: compoWidth,
          voieEngin: widget.voieEngin,
          allowAddingUsers: widget.allowAddingUser,
          allowCureentAffectation: widget.allowAddingCurrentUser,
        );
      }),
    );
  }

  reloadData() {
    widget.setStateParent!();
  }
}
