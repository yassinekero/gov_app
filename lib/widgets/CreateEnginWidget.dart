import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/Engin.dart';
import 'package:gov/models/EnginComposition.dart';
import 'package:gov/widgets/CreateEnginCompositionWidget.dart';
import 'package:gov/widgets/EnginCompositionWidget.dart';

class CreateEnginWidget extends StatefulWidget {
  const CreateEnginWidget(this.enginName, {super.key});

  @override
  State<CreateEnginWidget> createState() => _CreateEnginWidgetState();

  final String enginName;
}

class _CreateEnginWidgetState extends State<CreateEnginWidget> {
  late final Engin _engin;

  @override
  void initState() {
    _engin = Engin(
        id: -1,
        name: widget.enginName,
        composition: [
        ],
        longueur: 0);

    super.initState();
  }

  final TextEditingController _editingEnginLonguerController =
      TextEditingController(text: "0");

  bool _addingEngin = false;

  @override
  Widget build(BuildContext context) {
    final composition = _engin.composition;
    return SingleChildScrollView(
      child: Container(
        width: 800,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                controller: _editingEnginLonguerController,
                onChanged: (txt) => setState(() {
                      _engin.longueur = int.tryParse(txt) ?? 0;
                    }),
                keyboardType: TextInputType.number,
                maxLength: 4,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                    counterText: "",
                    suffix: Text("mètres"),
                    label: Text("Longueur d'engin"),
                    border: OutlineInputBorder())),
            SizedBox(height: 20),
            Text("Composition",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black38)),
            SizedBox(height: 10),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...List.generate(composition.length, (i) {
                  var compositionElm = composition[i];

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: null, icon: Text("${i + 1}")),
                            EnginCompositionWidget(compositionElm,
                                width: 70, reverse: composition.length == i + 1),
                            IconButton(
                                onPressed: () =>
                                    {setState(() => composition.removeAt(i))},
                                icon: Icon(Icons.delete_forever))
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  );
                }),
                Card(
                  child: TextButton(
                      onPressed: () async {
                        EnginComposition? enginComposition = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Ajouter un composant",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                  content: CreateEnginCompostionWidget(),
                                ));
                        if (enginComposition != null) {
                          _engin.longueur += 260;
                          _editingEnginLonguerController.text =
                              _engin.longueur.toString();

                          composition.add(enginComposition);
                          setState(() => {});
                        }
                      },
                      child: Icon(
                        Icons.add,
                        size: 40,
                      )),
                )
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
                SizedBox(width: 30),
                FilledButton(
                    onPressed: (_addingEngin ||
                            composition.isEmpty ||
                            _engin.longueur <= 0)
                        ? null
                        : () async{
                            setState(() => _addingEngin = true);

                            var createEnginRes = await Data.createEngin(_engin);

                            if(createEnginRes.status=="ok"){
                              Navigator.pop(context,createEnginRes.engin!);
                            }
                            setState(() => _addingEngin = false);
                            //
                          },
                    child: _addingEngin
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator())
                        : Text("Ajouter")),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _editingEnginLonguerController.dispose();
    super.dispose();
  }
}
