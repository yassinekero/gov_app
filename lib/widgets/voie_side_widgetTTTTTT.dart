import 'package:flutter/material.dart';
import 'package:gov/models/VoieTTTTT.dart';
import 'package:gov/models/VoieSide.dart';
import 'package:gov/widgets/AddEnginWidgetTTTT.dart';
import 'package:gov/widgets/text_border.dart';
import 'package:gov/widgets/uo_widget.dart';

class VoieSideWidgetTTTT extends StatefulWidget {
  const VoieSideWidgetTTTT(this.voie,this.voieSide,
      {this.crossAxisAlignment = CrossAxisAlignment.start, super.key});

  final VoieSide voieSide;
  final VoieTTTT voie;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  State<VoieSideWidgetTTTT> createState() => _VoieSideWidgetTTTTState();
}

class _VoieSideWidgetTTTTState extends State<VoieSideWidgetTTTT> {
  @override
  Widget build(BuildContext context) {
    final spacerI = SizedBox(width: 10);
    final estimmobiliseColor =
        widget.voieSide.engin != null ? Colors.red : Colors.grey;
    return Flex(
        crossAxisAlignment: widget.crossAxisAlignment,
        direction: Axis.vertical,
        children: [
          Opacity(
            opacity: widget.voieSide.engin == null ? 0.8 : 1,
            child: Row(children: [
              IntrinsicWidth(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  TextBorder(
                    widget.voieSide.engin?.name ?? "????",
                    color: widget.voieSide.engin?.color,
                  ),
                  TextBorder(widget.voieSide.sortirDate)
                ]),
                TextBorder(widget.voieSide.motif, width: double.infinity)
              ])),
              if (widget.voieSide.engin == null ||
                  widget.voieSide.estimmobilise)
                spacerI,
              if (widget.voieSide.engin == null ||
                  widget.voieSide.estimmobilise)
                Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                      border: Border.all(color: estimmobiliseColor, width: 1)),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            width: 30, height: 30, color: estimmobiliseColor),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            width: 30, height: 30, color: estimmobiliseColor),
                      )
                    ],
                  ),
                ),
              spacerI,
              UO_Widget(widget.voieSide.uoStatus),
              spacerI,
              Container(
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Expanded(
                            child: TextBorder("BT",
                                color: widget.voieSide.tensionStatus.BT
                                    ? Colors.red
                                    : null)),
                        Expanded(
                            child: TextBorder("HT",
                                color: widget.voieSide.tensionStatus.HT
                                    ? Colors.red
                                    : null))
                      ]),
                      Row(children: [
                        TextBorder("MT",
                            color: widget.voieSide.tensionStatus.MT
                                ? Colors.red
                                : null),
                        TextBorder("MAT",
                            color: widget.voieSide.tensionStatus.MAT
                                ? Colors.red
                                : null)
                      ]),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 20, width: 8),
          Container(
              child: widget.voieSide.engin?.getWidget() ??
                  FilledButton(
                    onPressed: () => {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Ajouter un engin",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          content: AddEnginWidgetTTTTT(widget.voie,widget.voieSide),
                          actions: [
                            ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Annuler")),
                            FilledButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text("Ajouter"))
                          ],
                        ),
                      ).then((value) => setState(() => {}))
                    },
                    child: Container(
                        width: 400,
                        child: Text(
                          "Ajouter un engin",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  )),
        ]);
  }
}
