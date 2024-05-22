import 'package:flutter/material.dart';
import 'package:gov/models/EnginComposition.dart';

class CreateEnginCompostionWidget extends StatefulWidget {
  CreateEnginCompostionWidget({super.key});

  @override
  State<CreateEnginCompostionWidget> createState() =>
      _CreateEnginCompostionWidgetState();

}

class _CreateEnginCompostionWidgetState
    extends State<CreateEnginCompostionWidget> {
  final EnginComposition _enginComposition = EnginComposition(-1, "", "");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (txt) => _enginComposition.name = txt,
              decoration: InputDecoration(label: Text("Identifiant de composant")),
            ),
            SizedBox(height: 20),
            SwitchListTile(
                title: Text("Motrice"),
                value: _enginComposition.type == "M",
                onChanged: (val) =>
                    setState(() => _enginComposition.type = val ? "M" : "V")),
            SizedBox(height: 15),
            FilledButton(onPressed: () => Navigator.pop(context,_enginComposition), child: Text("Ajouter"))
          ],
        ),
      ),
    );
  }
}
