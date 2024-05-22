import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gov/models/User.dart';

class MultipleSearchPerson extends StatefulWidget {
  const MultipleSearchPerson(
      {required this.listSelectedPersons,
      required this.fullListPersons,
      super.key});

  @override
  State<MultipleSearchPerson> createState() => _MultipleSearchPersonState();

  final List<User> listSelectedPersons;
  final List<User> fullListPersons;
}

class _MultipleSearchPersonState extends State<MultipleSearchPerson> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<User> listSelectedPersons = widget.listSelectedPersons;

    List<User> listUnSelectedPersons = [...widget.fullListPersons];
    listUnSelectedPersons.removeWhere((user) =>
        listSelectedPersons.firstWhereOrNull((sUser) => sUser.id == user.id) !=
        null);

    var textStyleTitle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: Colors.black54, fontWeight: FontWeight.bold);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Personnes sélectionnées(${listSelectedPersons.length})",
              style: textStyleTitle),
          Card(
              color: Colors.grey.shade200,
              child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxWidth: 800),
                  child: Wrap(
                      children: List.generate(listSelectedPersons.length, (i) {
                    var selectedPerson = listSelectedPersons[i];
                    return TextButton(
                      onPressed: () {
                        setState(
                            () => listSelectedPersons.remove(selectedPerson));
                      },
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        if (selectedPerson.img == null)
                          CircleAvatar(child: Icon(Icons.person))
                        else
                          CircleAvatar(
                            backgroundImage: NetworkImage(selectedPerson.img!),
                          ),
                        SizedBox(width: 5),
                        Text(selectedPerson.name,
                            style: Theme.of(context).textTheme.titleMedium),
                      ]),
                    );
                  })))),
          SizedBox(height: 20),
          Text("Le reste de votre atelier", style: textStyleTitle),
          SizedBox(height: 5),
          Center(
            child: Card(
              child: Container(
                height: 350,
                width: 500,
                child: ListView.builder(
                    itemCount: listUnSelectedPersons.length,
                    itemBuilder: (ctx, i) {
                      var unSelectedPerson = listUnSelectedPersons[i];

                      return ListTile(
                        leading: (unSelectedPerson.img == null)
                            ? CircleAvatar(child: Icon(Icons.person))
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(unSelectedPerson.img!),
                              ),
                        trailing: Text(unSelectedPerson.equipe!.name),
                        title: Text(unSelectedPerson.name),
                        subtitle: Text(unSelectedPerson.matricule),
                        onTap: () => setState(
                            () => listSelectedPersons.add(unSelectedPerson)),
                      );
                    }),
              ),
            ),
          )
        ]);
  }
}
