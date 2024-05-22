import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/UserEngin.dart';

class UserEnginEditWidget extends StatefulWidget {
  const UserEnginEditWidget(this.userEngin, {super.key});

  final UserEngin userEngin;

  @override
  State<UserEnginEditWidget> createState() => _UserEnginEditWidgetState();
}

class _UserEnginEditWidgetState extends State<UserEnginEditWidget> {
  bool isUpdating = false;
  bool isDeleting = false;

  String tempTache = "";

  @override
  void initState() {
    tempTache = widget.userEngin.tache;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.userEngin.user;

    final String userSituation;
    final Icon iconStatus;
    if (widget.userEngin.status == null) {
      userSituation = "Préaffecté";
      iconStatus = const Icon(Icons.help, size: 25, color: Colors.grey);
    } else if (!widget.userEngin.status!) {
      userSituation = "Affecté";
      iconStatus = const Icon(Icons.close, size: 25, color: Colors.red);
    } else {
      userSituation = "Terminé";
      iconStatus = const Icon(Icons.done, size: 25, color: Colors.green);
    }

    return Container(
      width: 650,
      padding: const EdgeInsets.only(top: 20),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          getDisabledTextField("Atelier", user.equipe?.atelier.name),
          getDisabledTextField("Equipe", user.equipe?.name),
          getDisabledTextField("Situation", userSituation, icon: iconStatus),
          TextFormField(
              initialValue: tempTache,
              onChanged: (txt) => tempTache = txt,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Tache"))),
          Row(
            children: [
              Spacer(),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Annuler")),
              SizedBox(width: 10),

              if( (widget.userEngin.status == null))
              FilledButton(style: FilledButton.styleFrom(backgroundColor: Colors.blueGrey),
                  onPressed: isDeleting?null: () async {
                    setState(() =>
                      isDeleting = true
                    );

                    var userEnginStatus = await Data.deleteUserEngin(widget.userEngin.id);

                    if(userEnginStatus.status=="ok"){
                      Navigator.pop(context,true);
                    }
                    setState(() =>
                      isDeleting = false
                    );


                  },
                  child: Text("Désaffecter")),
              SizedBox(width: 10),
              FilledButton(
                  onPressed: isUpdating
                      ? null
                      : () async {
                          setState(() {
                            isUpdating = true;
                          });
                          String oldTempTache = widget.userEngin.tache;
                          widget.userEngin.tache = tempTache;

                          var updateUserEnginResponse =
                              await Data.updateUserEngin(widget.userEngin);

                          if (updateUserEnginResponse.status == "ok") {
                            Navigator.pop(context);
                          } else {
                            widget.userEngin.tache = oldTempTache;
                          }

                          setState(() {
                            isUpdating = false;
                          });
                        },
                  child: const Text("Sauvegarder"))
            ],
          )
        ],
      ),
    );
  }

  Widget getDisabledTextField(String label, String? val, {Widget? icon}) {
    return Container(
      width: 200,
      child: TextFormField(
        initialValue: val,
        decoration: InputDecoration(
            suffixIcon: icon,
            enabled: false,
            border: const OutlineInputBorder(),
            label: Text(label)),
      ),
    );
  }
}
