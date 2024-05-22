import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gov/Data.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gov/models/Atelier.dart';
import 'package:gov/models/Equipe.dart';
import 'package:gov/models/User.dart';
import 'package:gov/widgets/NavigationDrawerAdmin.dart';
import 'package:http/http.dart' as http;
import '../models/Role.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  late Widget interface;
  late List<Role> roles;
  late List<Equipe> equipes;
  late Equipe equipe = Equipe(name: "", dpx_id: 0, atelier_id: 0, atelier: Atelier(name: "", duo_id: 0, created_at: DateTime.now()));
  late String role;
  TextEditingController matriculeController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController mdpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    interface = loading();
    super.initState();
  }

  Widget loading(){

    getRoles();

    return Scaffold(
      body: Container(
        child: SpinKitRing(
          color: Color.fromRGBO(74, 32, 170, 1.0),
          size: 50.0,
        ),
      ),
    );
  }


  Widget loaded(){
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white70,
      ),
      drawer: const NavigationDrawerAdmin(),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: ConstrainedBox(
            constraints: constraints.copyWith(minHeight: constraints.maxHeight, maxHeight: double.infinity),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color : Colors.grey
                        ),
                        borderRadius: new BorderRadius.all(
                            const Radius.circular(5)
                        )
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: roles.map<DropdownMenuItem<String>>((Role value) {
                          return DropdownMenuItem<String>(
                            value: value.key,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 60,
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                child: Text(value.name),
                              ),
                            ),
                          );
                        }).toList(),
                        value: role,
                        alignment: Alignment.center,
                        onChanged: (String? newval){
                          setState(() {
                            role = newval.toString();
                            interface = loaded();
                          });
                        },),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      onEditingComplete: (){

                      },
                      controller: matriculeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        labelText: 'Matricule*',
                        //errorText: prenomIsEmpty ? 'Entrez un prénom valide' : null
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      onEditingComplete: (){

                      },
                      controller: nomController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        labelText: 'Nom*',
                        //errorText: prenomIsEmpty ? 'Entrez un prénom valide' : null
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      onEditingComplete: (){

                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        labelText: 'Email',
                        //errorText: prenomIsEmpty ? 'Entrez un prénom valide' : null
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      onEditingComplete: (){

                      },
                      controller: telController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        labelText: 'Téléphone',
                        //errorText: prenomIsEmpty ? 'Entrez un prénom valide' : null
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      onEditingComplete: (){

                      },
                      controller: mdpController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        labelText: 'Mot de passe*',
                        //errorText: prenomIsEmpty ? 'Entrez un prénom valide' : null
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: (role != 'duo' && role!='dpx' && equipe.name != ""),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color : Colors.grey
                          ),
                          borderRadius: new BorderRadius.all(
                              const Radius.circular(5)
                          )
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: equipes.map<DropdownMenuItem<Equipe>>((Equipe value) {
                            return DropdownMenuItem<Equipe>(
                              value: value,
                              child: Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 60,
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                  child: Text(value.name),
                                ),
                              ),
                            );
                          }).toList(),
                          value: equipe,
                          alignment: Alignment.center,
                          onChanged: (Equipe? newval){
                            setState(() {
                              equipe = newval!;
                              interface = loaded();
                            });
                          },),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton.extended(
                    label: Text('Ajouter un utilisateur'),
                      onPressed: (){
                        User us = User(matricule: matriculeController.text, name: nomController.text, email: emailController.text,password: mdpController.text, equipe_id: equipe.id, created_at: DateTime.now(), role_key: role);
                        Data.addUser(us, context);
                      }),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );}
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return interface;
  }


   Future getRoles() async {

     final response = await http.get(Uri.parse('${Data.hostUrl}/get_equipe'));

     if (response.statusCode == 200) {
       dynamic r = json.decode(response.body);
       List<Equipe> eq = List<Equipe>.from(
           r['roless'].map((r) => Equipe.fromJson(r)));

       equipes = eq;
       if(equipes.isNotEmpty){
         equipe = equipes[0];
       }
     } else {
       // If the server did not return a 200 OK response,
       // then throw an exception.
       throw Exception('Failed to load');
     }


    final response1 = await http.get(Uri.parse('${Data.hostUrl}/get_role'));

    if (response1.statusCode == 200) {
      dynamic r1 = json.decode(response1.body);

      List<Role> ro = List<Role>.from(
          r1['roless'].map((r) => Role.fromJson(r)));


      roles = ro;
      role = roles[0].key;
      setState((){
        interface = loaded();
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

}
