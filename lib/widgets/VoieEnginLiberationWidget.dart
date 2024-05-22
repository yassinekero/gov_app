import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/VoieEngin.dart';

class VoieEnginLiberationWidget extends StatefulWidget {
  const VoieEnginLiberationWidget(this.voieEngin, {super.key});

  @override
  State<VoieEnginLiberationWidget> createState() =>
      _VoieEnginLiberationWidgetState();

  final VoieEngin voieEngin;
}

class _VoieEnginLiberationWidgetState extends State<VoieEnginLiberationWidget> {
  late final int enginLongueur;

  late final int nb_assigned_not_started;
  late final int nb_started_work;
  late final int nb_finished_work;

  late final int nb_ateliers_started_work;
  late final int nb_ateliers_finished_work;

  bool statsUsersLoading = true, statsAtelierLoading = true;

  @override
  void initState() {
    Data.getVoieEnginsUsers(widget.voieEngin.id!).then((compositionsWithUsers) {
      int nbAssignedNotStarted = 0;
      int nbStartedWork = 0;
      int nbFinishedWork = 0;

      for (var elmt in compositionsWithUsers) {
        nbAssignedNotStarted += elmt.nb_assigned_not_started!;
        nbStartedWork += elmt.nb_started_work!;
        nbFinishedWork += elmt.nb_finished_work!;
      }
      nb_assigned_not_started = nbAssignedNotStarted;
      nb_started_work = nbStartedWork;
      nb_finished_work = nbFinishedWork;

      setState(() => statsUsersLoading = false);
    });
    Data.getEnginAteliers(widget.voieEngin.id!).then((enginAteliers) {
      int nbAteliersStartedWork = 0;
      int nbAteliersFinishedWork = 0;
      for (var enginAtelier in enginAteliers) {
        if (!enginAtelier.status) {
          nbAteliersStartedWork += 1;
        } else if (enginAtelier.status) {
          nbAteliersFinishedWork += 1;
        }
      }
      nb_ateliers_started_work = nbAteliersStartedWork;
      nb_ateliers_finished_work = nbAteliersFinishedWork;

      setState(() => statsAtelierLoading = false);
    });

    super.initState();
  }

  bool voieEnginIsDeleting = false;

  @override
  Widget build(BuildContext context) {
    bool enginVide = !statsUsersLoading &&
        ((nb_assigned_not_started + nb_started_work) == 0);
    bool ateliersFree = !statsAtelierLoading && (nb_ateliers_started_work == 0);

    return SizedBox(
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Personne dans l\'engin.'),
            subtitle: (!enginVide) && !statsUsersLoading
                ? Text("  -> $nb_started_work pas encore terminés"
                    "\n  -> $nb_assigned_not_started pas commencé")
                : null,
            trailing: statsUsersLoading
                ? CircularProgressIndicator()
                : _getIcon(enginVide),
          ),
          ListTile(
            title: Text('Les ateliers ont terminé.'),
            subtitle: (!ateliersFree) && !statsAtelierLoading
                ? Text("  -> $nb_ateliers_started_work pas encore terminés")
                : null,
            trailing: statsAtelierLoading
                ? CircularProgressIndicator()
                : _getIcon(ateliersFree),
          ),
          SizedBox(height: 20),
          FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent),
              onPressed: (!statsUsersLoading &&
                      !statsAtelierLoading &&
                      enginVide &&
                      ateliersFree &&
                      !voieEnginIsDeleting)
                  ? () async {
                      setState(() => voieEnginIsDeleting = true);

                      var enginResponse =
                          await Data.deleteVoieEngin(widget.voieEngin.id!);

                      if (enginResponse.status == "ok") {
                        Navigator.pop(context, true);
                      }

                      setState(() => voieEnginIsDeleting = false);
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (voieEnginIsDeleting)
                    CircularProgressIndicator()
                  else
                    Text(
                      "Libérer",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                ],
              ))
        ],
      ),
    );
  }

  Widget _getIcon(bool status) {
    final Icon iconStatus;

    if (!status) {
      iconStatus = Icon(Icons.close, size: 25, color: Colors.red);
    } else {
      iconStatus = Icon(Icons.done, size: 25, color: Colors.green);
    }

    return iconStatus;
  }
}
