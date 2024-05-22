import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/Engin.dart';
import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/EnginSerie.dart';
import 'package:gov/models/Voie.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:gov/widgets/EnginWidget.dart';
import 'package:gov/widgets/VoieEnginLiberationWidget.dart';

import 'CreateEnginWidget.dart';

class AddEditEnginWidget extends StatefulWidget {
  const AddEditEnginWidget(this.voie,
      {required this.minPos,
      required this.maxPos,
      super.key,
      this.voieEnginToEdit});

  @override
  State<AddEditEnginWidget> createState() => _AddEditEnginWidgetState();

  final Voie voie;
  final double minPos;
  final double maxPos;

  final VoieEngin? voieEnginToEdit;
}

class _AddEditEnginWidgetState extends State<AddEditEnginWidget> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    _currentRangeValues = RangeValues(widget.minPos, widget.minPos + 10);

    voieEnginToAdd =
        VoieEngin(voie_id: widget.voie.id!, created_at: DateTime(201));

    super.initState();

    // Data.getFreeEngins(1);

    _enginNameEditingController.addListener(() {
      if (selectedEnginSerie == null ||
          selectedEnginSerie!.freeEngins == null) {
        return;
      }

      final text = _enginNameEditingController.value.text;

      var firstWhereOrNull = selectedEnginSerie!.freeEngins!
          .firstWhereOrNull((eng) => eng.name == text);
      if (_selectedEngin != firstWhereOrNull) {
        _selectedEngin = firstWhereOrNull;

        _currentRangeValues = RangeValues(
            widget.minPos, widget.minPos + _selectedEngin!.longueur);

        
        setState(() => {});
      }
    });

    Data.getEnginSeries().then((value) {
      enginSeries = value;
      //value.add(EnginSerie(null, "RAME"));
      setState(() {});
    });

    if (widget.voieEnginToEdit != null) {
      _editMode = true;
      voieEnginToAdd = widget.voieEnginToEdit!;

      _selectedEngin = voieEnginToAdd!.engin!;
      selectedEnginSerie = _selectedEngin!.serie;

      _enginNameEditingController.text = _selectedEngin!.name;

      setState(() {
        if(selectedEnginSerie?.name == "RAME"){
          compo_visibility = true;
        }else{
          compo_visibility = false;
        }
      });
    }

    if(voieEnginToAdd!.engin != null){
      if(voieEnginToAdd!.engin!.serie!.name == 'RAME'){
        for(var c in voieEnginToAdd!.engin!.composition){
          if(c.name[0] == "1"){
            Nb1++;
          }else if(c.name[0] == "2"){
            Nb2++;
          }else{
            Nblit++;
          }
        }
      }
    }
  }

  int currentPage = 0;

  VoieEngin? voieEnginToAdd;
  bool _editMode = false;

  List<EnginSerie> enginSeries = [];

  EnginSerie? selectedEnginSerie;
  Engin? _selectedEngin;
  bool voieEnginAdding = false;
  bool compo_visibility = false;
  int Nb1 = 0;
  int Nb2 = 0;
  int Nblit = 0;


  final TextEditingController _enginNameEditingController =
      TextEditingController();

  Widget get _errorText {
    if (_selectedEngin == null) {
      return const Icon(Icons.error, color: Colors.red);
    }

    return const Icon(Icons.check, color: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: Colors.black54);





    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Choisir un engin", style: labelStyle),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                        style: BorderStyle.solid,
                      ),
                      color: Colors.white,
                    ),
                    child: DropdownButton(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        underline: Container(),
                        hint: enginSeries.isEmpty
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                width: 25,
                                height: 25,
                                child: const CircularProgressIndicator())
                            : Text(_editMode
                                ? voieEnginToAdd!.engin!.getSerieName
                                : "Serie"),
                        value: selectedEnginSerie,
                        items: _editMode
                            ? null
                            : enginSeries
                                .map((serie) => DropdownMenuItem(
                                    value: serie,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        serie.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    )))
                                .toList(),
                        onChanged: (r) => setState(() {
                              _enginNameEditingController.text = "";
                              selectedEnginSerie = r;
                            })),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TypeAheadFormField(
                      noItemsFoundBuilder: (context) {
                        return selectedEnginSerie!.id != null
                            ? const ListTile(
                                title: Text("Aucun engin libre avec ce nom"),
                              )
                            : ListTile(
                                title: Text(
                                    "Créer un nouvel engin(${_enginNameEditingController.text})"),
                                onTap: () async {
                                  Engin? _enginNew = await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                                "Créer un nouvel engin(${_enginNameEditingController.text})",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center),
                                            content: CreateEnginWidget(
                                                _enginNameEditingController
                                                    .text),
                                          ));
                                  if (_enginNew != null) {
                                    selectedEnginSerie!.freeEngins!
                                        .add(_enginNew);
                                    setState(() {
                                      _selectedEngin = _enginNew;
                                    });
                                  }
                                  // _selectedEngin=_enginNew;
                                },
                              );
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                          enabled: !_editMode && selectedEnginSerie != null,
                          controller: _enginNameEditingController,
                          autofocus: true,
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontStyle: FontStyle.italic),
                          decoration: InputDecoration(
                              suffix: _errorText,
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(),
                              prefix: Text("${selectedEnginSerie?.name} "),
                              label: const Text("Identifiant de l'engin"))),
                      suggestionsCallback: (pattern) async {
                        var a = Future<List<Engin>>(() async {
                          if (selectedEnginSerie!.freeEngins == null) {
                            selectedEnginSerie!.freeEngins =
                                await Data.getFreeEngins(
                                    selectedEnginSerie!.id);
                          }

                          return selectedEnginSerie!.freeEngins!
                              .where((engin) => engin.name
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .toList();
                        });

                        return await a;
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          leading: Text(selectedEnginSerie!.name),
                          title: Text(suggestion.name),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        if(selectedEnginSerie!.name == 'RAME'){
                          compo_visibility = true;
                        }
                        _enginNameEditingController.text = suggestion.name;
                        _selectedEngin!.serie = selectedEnginSerie;
                        setState(() {
                        });
                      },
                    ),
                  ),
                ],
              )),
          Visibility(
            visible: compo_visibility,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nb. voitures -1ere classe-"),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: (){Nb1 != 0 ? Nb1-- : Nb1 = 0; setState(() {
                                  _selectedEngin!.longueur = _selectedEngin!.longueur - 250;
                                });},
                                icon: Icon(Icons.remove)),
                            Text("$Nb1"),
                            IconButton(
                                onPressed: (){Nb1 < 5 ? Nb1++ : Nb1 = 5; setState(() {
                                  _selectedEngin!.longueur = _selectedEngin!.longueur + 250;
                                });},
                                icon: Icon(Icons.add)),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nb. voitures -2eme classe-"),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: (){Nb2 != 0 ? Nb2-- : Nb2 = 0; setState(() {
                                  _selectedEngin!.longueur = _selectedEngin!.longueur - 250;
                                });},
                                icon: Icon(Icons.remove)),
                            Text("$Nb2"),
                            IconButton(
                                onPressed: (){Nb2 < 9 ? Nb2++ : Nb2 = 9; setState(() {
                                  _selectedEngin!.longueur = _selectedEngin!.longueur + 250;
                                });},
                                icon: Icon(Icons.add)),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nb. wagons lits"),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: (){Nblit != 0 ? Nblit-- : Nblit = 0; setState(() {
                                  _selectedEngin!.longueur = _selectedEngin!.longueur - 250;
                                });},
                                icon: Icon(Icons.remove)),
                            Text("$Nblit"),
                            IconButton(
                                onPressed: (){Nblit < 3 ? Nblit++ : Nblit = 3; setState(() {
                                  _selectedEngin!.longueur = _selectedEngin!.longueur + 250;
                                });},
                                icon: Icon(Icons.add)),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_selectedEngin != null)
                  EnginWidget(_selectedEngin!,true)
                else
                  Container(
                    width: 0,
                    height: 0,
                    child: const Placeholder(
                      child: Text("anas darai"),
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Positionnement: ", style: labelStyle),
              const SizedBox(
                height: 5,
              ),
              if (widget.maxPos - widget.minPos >
                  (_selectedEngin?.longueur ?? double.infinity))
                Row(
                  children: [
                    Text("${widget.minPos.toInt()}"),
                    Expanded(
                      child: RangeSlider(
                        values: _currentRangeValues,
                        min: widget.minPos,
                        max: widget.maxPos,
                        divisions: 100,
                        labels: RangeLabels(
                          "${_currentRangeValues.start.round()}m",
                          _currentRangeValues.end.round().toString() + "m",
                        ),
                        /* onChanged: (RangeValues values){
                          setState(() {
                              _currentRangeValues = values;
                          });
                    },*/
                        onChanged: (RangeValues values) {
                          var longueurEngin = _selectedEngin!.longueur;
                          setState(() {
                            RangeValues newValues;

                            if (_currentRangeValues.start != values.start) {
                              newValues = RangeValues(
                                  values.start, values.start + longueurEngin);
                            } else {
                              newValues = RangeValues(
                                  values.end - longueurEngin, values.end);
                            }

                            if (newValues.start < widget.minPos) {
                              newValues = RangeValues(widget.minPos,
                                  widget.minPos + longueurEngin.toDouble());
                            } else if (newValues.end > widget.maxPos) {
                              newValues = RangeValues(
                                  widget.maxPos - longueurEngin.toDouble(),
                                  widget.maxPos);
                            }

                            _currentRangeValues = newValues;
                            voieEnginToAdd!.position_voie =
                                newValues.start.toInt();
                          });
                        },
                        onChangeEnd: (values) {
                          print(values);
                        },
                      ),
                    ),
                    Text("${widget.maxPos.toInt()}"),
                  ],
                )
              else if (_selectedEngin != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    Text("Pas d'espace pour emplacer cet engin!",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.redAccent))
                  ],
                ),
              const SizedBox(height: 10),
              Text("Information d'entrée: ", style: labelStyle),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            initialValue: voieEnginToAdd?.motif,
                            textInputAction: TextInputAction.next,
                            onChanged: (txt) => voieEnginToAdd!.motif = txt,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white54,
                                prefix: Icon(Icons.bookmark),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                label: Text("Motif")),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Spacer(),
                        SizedBox(
                            width: 350,
                            child: TextFormField(
                              initialValue: voieEnginToAdd?.prevision_sortie,
                              onChanged: (txt) =>
                                  voieEnginToAdd!.prevision_sortie = txt,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white54,
                                  prefix: Icon(Icons.date_range),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  label: Text("Prévision de sortie")),
                            ))
                      ]),
                      const SizedBox(height: 20),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: voieEnginToAdd?.comment,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.multiline,
                            //minLines: 3,
                            maxLines: null,
                            onChanged: (txt) => voieEnginToAdd!.comment = txt,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white54,
                                prefix: Icon(Icons.comment),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                label: Text("Comment")),
                          ),
                        )
                      ]),
                    ],
                  )),
              const SizedBox(height: 10),
              Text("Nature d'engin: ", style: labelStyle),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchListTile(
                        title: const Text("Engin immobilisé"),
                        value: voieEnginToAdd!.estimmobilise,
                        onChanged: (val) => setState(
                            () => voieEnginToAdd!.estimmobilise = val)),
                    const SizedBox(height: 10),
                    SwitchListTile(
                        title: const Text("Coactivité interdite"),
                        value: voieEnginToAdd!.coactivite,
                        onChanged: (val) =>
                            setState(() => voieEnginToAdd!.coactivite = val)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text("Nature de tension: ", style: labelStyle),
              const SizedBox(height: 10),
              Center(
                child: Wrap(
                    spacing: 30,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      getBoolWidget(
                          () =>
                              voieEnginToAdd!.basset = !voieEnginToAdd!.basset,
                          voieEnginToAdd!.basset,
                          "BT"),
                      getBoolWidget(
                          () => voieEnginToAdd!.moyennet =
                              !voieEnginToAdd!.moyennet,
                          voieEnginToAdd!.moyennet,
                          "MT"),
                      getBoolWidget(
                          () =>
                              voieEnginToAdd!.hautet = !voieEnginToAdd!.hautet,
                          voieEnginToAdd!.hautet,
                          "HT"),
                      getBoolWidget(
                          () => voieEnginToAdd!.miseaterre =
                              !voieEnginToAdd!.miseaterre,
                          voieEnginToAdd!.miseaterre,
                          "MAT"),
                    ]),
              ),
              const SizedBox(height: 30),
              Row(children: [
                if (_editMode)
                  FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.deepOrange),
                      onPressed: () async {
                        bool? _isDeleted = await showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                      "Libérer l'engin (${_selectedEngin!.fullName})",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                  content: VoieEnginLiberationWidget(
                                      voieEnginToAdd!),
                                ));
                        if(_isDeleted!=null&&_isDeleted) {
                          Navigator.pop(context,true);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.new_releases),
                          SizedBox(width: 5),
                          Text(
                            "Libérer",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                if(_editMode)
                  SizedBox(width: 20,),
                if (_editMode && !voieEnginToAdd!.confirme)
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                    onPressed: () async {
                      Data.confirmVoieEngin(voieEnginToAdd!.id!).then((value) => value == true ? Navigator.pop(context) : print('error confirme'));

                    },
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_sharp),
                        SizedBox(width: 5),
                        Text(
                          "Confirmer",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                if (_editMode && voieEnginToAdd!.confirme)
                  FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.deepOrange),
                      onPressed: () async {
                        voieEnginToAdd!.estimmobilise = false;
                        voieEnginToAdd!.coactivite = false;
                        voieEnginToAdd!.basset = true;
                        voieEnginToAdd!.moyennet = true;
                        voieEnginToAdd!.hautet = true;
                        voieEnginToAdd!.miseaterre = false;
                        Data.tempVE = voieEnginToAdd;
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 5),
                          Text(
                            "Modifier la voie",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                const SizedBox(
                  width: 20,
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Annuler")),
                const SizedBox(
                  width: 20,
                ),
                FilledButton(
                    onPressed: (voieEnginAdding || _selectedEngin == null)
                        ? null
                        : () async {
                            setState(() => voieEnginAdding = true);
                            voieEnginToAdd!.engin_id = _selectedEngin!.id;
                            voieEnginToAdd!.engin = _selectedEngin!;
                            voieEnginToAdd!.position_voie =
                                _currentRangeValues.start.toInt();
                            int updateCompo = 200;
                            if(voieEnginToAdd!.engin!.serie!.name == 'RAME'){
                              voieEnginToAdd!.engin!.composition!.removeRange(0, voieEnginToAdd!.engin!.composition!.length);
                              voieEnginToAdd!.engin!.longueur = 0;
                              for (int i = 1; i<Nb1+1; i++){
                                voieEnginToAdd!.engin!.composition!.add(EnginComposition(int.parse("1${i}"), "1$i", "V"));
                                voieEnginToAdd!.engin!.longueur = voieEnginToAdd!.engin!.longueur + 250;
                              }
                              for (int i = 1; i<Nb2+1; i++){
                                voieEnginToAdd!.engin!.composition!.add(EnginComposition(int.parse("2$i"), "2$i", "V"));
                                voieEnginToAdd!.engin!.longueur = voieEnginToAdd!.engin!.longueur + 250;
                              }
                              for (int i = 1; i<Nblit+1; i++){
                                voieEnginToAdd!.engin!.composition!.add(EnginComposition(int.parse("3$i"), "3$i", "V"));
                                voieEnginToAdd!.engin!.longueur = voieEnginToAdd!.engin!.longueur + 250;
                              }

                              updateCompo = await Data.updateCompo(voieEnginToAdd!.engin!);
                            }

                            if(updateCompo == 200){
                              final addEnginToVoie =
                              await Data.addOrUpdateVoieEngin(
                                  voieEnginToAdd!);

                              if (addEnginToVoie.status == "ok") {
                                Navigator.pop(context, addEnginToVoie.voieEngin);
                              }

                              setState(() {
                                voieEnginAdding = false;
                                Data.tempVE = null;
                              });
                            }

                          },
                    child: voieEnginAdding
                        ? Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: const CircularProgressIndicator())
                        : Text(_editMode ? "Modifier" : "Ajouter"))
              ])
            ],
          ),
        ],
      ),
    );
  }

  Widget getBoolWidget(Function fun, bool val, String text) {
    return InkWell(
        onTap: () => setState(() => fun()),
        child: Container(
            width: 70,
            height: 70,
            color: val ? Colors.lightGreen : Colors.red,
            child: Center(
                child: Text(text,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold)))));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
