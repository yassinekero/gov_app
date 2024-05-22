import 'package:flutter/material.dart';
import 'package:gov/models/EnginTTT.dart';
import 'package:gov/models/Person.dart';
import 'package:gov/widgets/add_person_aff_widget.dart';
import 'package:gov/widgets/person_widget.dart';

class AffectPersonsSideWidget extends StatefulWidget {
  const AffectPersonsSideWidget(
      {
      required this.engin,
      this.isRight = false,
      super.key});


  final EnginTT engin;
  final bool isRight;

  @override
  State<AffectPersonsSideWidget> createState() =>
      _AffectPersonsSideWidgetState();
}

class _AffectPersonsSideWidgetState extends State<AffectPersonsSideWidget> {
  @override
  Widget build(BuildContext context) {

    final List<Person> listPersons=[];

    widget.engin.composition.forEach((element) =>
        listPersons.addAll(element.listPersonAffc));


    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            widget.isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ...List.generate(listPersons.length,
              (i) => PersonWidget(listPersons[i],reverse: widget.isRight,)),
          ElevatedButton(
              onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "Affecter des personnes",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                //        content: AddPersonAffecWidget(widget.engin),
                        actions: [
                          ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Annuler")),
                          FilledButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text("Enregistrer"))
                        ],
                      ),
                    ).then((value) => setState(() => {}))
                  },
              child: Icon(Icons.add))
        ]);
  }
}
