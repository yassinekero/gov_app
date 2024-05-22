import 'package:flutter/material.dart';

class ConfirmationDialogByWriting extends StatefulWidget {
  const ConfirmationDialogByWriting(this.variableName, this.variableNewVal,
      {super.key});

  @override
  State<ConfirmationDialogByWriting> createState() =>
      _ConfirmationDialogByWritingState();

  final String variableName, variableNewVal;
}

class _ConfirmationDialogByWritingState
    extends State<ConfirmationDialogByWriting> {


  @override
  Widget build(BuildContext context) {
    final String variableName = widget.variableName,
        variableNewVal = widget.variableNewVal;

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Le statut du service sera changé en \"$variableName=$variableNewVal\". êtes-vous sur de vouloir continuer?",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black54),
            ),
            SizedBox(height: 20),
            Text(
              "Veuillez taper \"CONFIRMER\" ci-dessous pour confirmer.",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),
           Row(mainAxisAlignment: MainAxisAlignment.end,children: [
             ElevatedButton(
                 onPressed: () => {Navigator.pop(context)},
                 child: Padding(
                   padding: const EdgeInsets.all(10),
                   child: Text("ANNULER"),
                 )),
             SizedBox(width: 30),
             FilledButton(
                 onPressed: () => {Navigator.pop(context, true)},
                 child: Padding(
                   padding: const EdgeInsets.all(10),
                   child: Text("CONFIRMER"),
                 ))

           ],)


          ]),
    );
  }
}
