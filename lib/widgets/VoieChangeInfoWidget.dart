import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/Voie.dart';
import 'package:gov/widgets/ConfirmationDialogByWriting.dart';
import 'package:gov/widgets/DialogCheckTechHabilite.dart';

class VoieChangeInfoWidget extends StatefulWidget {
  final Voie voie;

  const VoieChangeInfoWidget(this.voie, {super.key});

  @override
  State<VoieChangeInfoWidget> createState() => _VoieChangeInfoWidgetState();
}

class _VoieChangeInfoWidgetState extends State<VoieChangeInfoWidget> {
  bool voieUpdating = false;
  late final bool initialTension ;

 late final Voie voie ;
  @override
  void initState() {
    voie = widget.voie;
    initialTension=voie.sous_tension;


    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      child: Container(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
                title: const Text("Hors service"),
                value: voie.hors_service,
                onChanged: (val) async {
                  var confirmed =
                      await getConfirmedAlert("Hors service", val.toString());

                  if (confirmed) setState(() => voie.hors_service = val);
                }),
            if(voie.electrifiee)
            ListTile(
              title: const Text("Sous tension"),
              onTap: ()=> showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: Text("L'avancement du technicien(Voie ${voie.id})",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    content: DialogCheckTechHabilite(voie)),
              ),
              trailing: voie.valide_coupure == null
                  ? Text(
                      "Non validé".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  : Switch(
                      value: voie.sous_tension,
                      onChanged: (val) async {
                        var confirmed = await getConfirmedAlert(
                            "Sous tension", val.toString());
                        if (confirmed) {
                          setState(() => voie.sous_tension = val);





                        };
                      }),
            ),
            /* SwitchListTile(
                title: const Text("Sous tension"),
                value: voie.sous_tension,
                onChanged: voie.hors_service
                    ? null
                    : (val) async {
                        var confirmed = await getConfirmedAlert(
                            "Sous tension", val.toString());

                        if (confirmed) setState(() => voie.sous_tension = val);
                      }),*/
            const SizedBox(height: 20),
            TextFormField(
              initialValue: voie.comment,
              onChanged: (txt) => voie.comment = txt,
              decoration: const InputDecoration(
                  label: Text("Commentaire"), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      voie.sous_tension=initialTension;
                          Navigator.pop(context);


                    },
                    child: Text("Annuler")),
                const SizedBox(width: 15),
                FilledButton(
                    onPressed: voieUpdating
                        ? null
                        : () async {
                            setState(() => voieUpdating = true);

                            if(initialTension!=voie.sous_tension){
                              var updateVoieSousTension = await Data.updateVoieSousTension(voie);
                              if (updateVoieSousTension.status != "ok") {
                                setState(() => voieUpdating = false);
                                return ;
                              }
                            }

                            var addEnginToVoie = await Data.updateVoie(voie);
                            if (addEnginToVoie.status == "ok")
                              Navigator.pop(context, true);

                            setState(() => voieUpdating = false);
                          },
                    child: voieUpdating
                        ? Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: CircularProgressIndicator())
                        : Text("Save"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> getConfirmedAlert(
      String variableName, String variableNewVal) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation du changement",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        content: ConfirmationDialogByWriting(variableName, variableNewVal),
        /*actions: [
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Annuler")),
                      FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text("Ajouter"))
                    ],*/
      ),
    );
  }
}
