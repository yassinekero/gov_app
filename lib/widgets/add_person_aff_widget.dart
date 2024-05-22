import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/ROLES.dart';
import 'package:gov/models/User.dart';
import 'package:gov/widgets/MultipleSearchPerson.dart';

class AddPersonAffecWidget extends StatefulWidget {
  final EnginComposition enginComposition;

  const AddPersonAffecWidget(this.voieEnginId,this.enginComposition, {super.key});

  @override
  State<AddPersonAffecWidget> createState() => _AddPersonAffecWidgetState();


  final int voieEnginId;


}

class _AddPersonAffecWidgetState extends State<AddPersonAffecWidget> {

  bool isAdding=false;
  @override
  void initState() {
    listSelectedAtelierUsers = widget.enginComposition.userEngins!
        .map((userEngin) => userEngin.user)
        .toList();




    Future<List<User>> usersOfAtelierOrEquipe ;


    if(Data.currentUserRole==ROLES.DUO){
      usersOfAtelierOrEquipe=Data.getAtelierUsers();
    }else// if(Data.currentUserRole==ROLES.DPX)
    {
      usersOfAtelierOrEquipe=Data.getEquipesUsers();
    }



    usersOfAtelierOrEquipe.then((users) {
      setState(() {
        listAllAtelierUser.addAll(users);

        listAllAtelierUser.removeWhere((user) =>
            listSelectedAtelierUsers
                .firstWhereOrNull((sUser) => sUser.id == user.id) !=
            null);
      });
    });



    super.initState();
  }

  final List<User> listAllAtelierUser = [];
  final List<User> listNewUsersToAdd = [];
  late final List<User> listSelectedAtelierUsers;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: SingleChildScrollView(
                child: MultipleSearchPerson(
          listSelectedPersons: listNewUsersToAdd,

          // fullListPersons:  enginComposition.userEngins!.map((userEngin) => userEngin.user).toList(),
          fullListPersons: listAllAtelierUser,
        ))),
        SizedBox(height: 10),
        Row(children:  [
          Spacer(),
          ElevatedButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: Text("Annuler")),
          SizedBox(width: 10),
          FilledButton(
              onPressed: isAdding?null:() async {
                setState(() {
                  isAdding=true;
                });
                var addUsersToCompositionEngin = await Data.addUsersToCompositionEngin(listNewUsersToAdd, widget.voieEnginId,  widget.enginComposition.id);


                if(addUsersToCompositionEngin.status=="ok"){
                  Navigator.pop(context, true);
                }

                setState(() {
                  isAdding=false;
                });


          },
              child: Text("Affecter"))
        ],)

      ],
    );
  }
}
