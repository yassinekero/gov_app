import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/Atelier.dart';
import 'package:gov/models/User.dart';
import 'package:gov/widgets/NavigationDrawerAdmin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAtelier extends StatefulWidget {
  const AddAtelier({Key? key}) : super(key: key);

  @override
  State<AddAtelier> createState() => _AddAtelierState();
}

class _AddAtelierState extends State<AddAtelier> {
  late Widget interface;
  TextEditingController codeController = TextEditingController();
  TextEditingController atelierController = TextEditingController();
  late User chef;
  late List<User> listChefs;

  @override
  void initState() {
    // TODO: implement initState
    interface = loading();
    super.initState();
  }

  Widget loading(){
    getChefs();
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
                    child: TextField(
                      onEditingComplete: (){

                      },
                      controller: atelierController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        labelText: 'Nom atelier*',
                        //errorText: prenomIsEmpty ? 'Entrez un prénom valide' : null
                      ),
                    ),
                  ),
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
                        items: listChefs.map<DropdownMenuItem<User>>((User value) {
                          return DropdownMenuItem<User>(
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
                        value: chef,
                        alignment: Alignment.center,
                        onChanged: (User? newval){
                          setState(() {
                            chef = newval!;
                            interface = loaded();
                          });
                        },),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton.extended(
                      label: Text('Ajouter un atelier'),
                      onPressed: (){
                        Atelier at = Atelier( name: atelierController.text, duo_id: chef.id!, created_at: DateTime.now());
                        Data.addAtelier(at, context);
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

  Future getChefs() async {

    final response = await http.get(Uri.parse('${Data.hostUrl}/get_duo'));

    if (response.statusCode == 200) {
      dynamic r1 = json.decode(response.body);

      List<User> ro = List<User>.from(
          r1['chefs'].map((r) => User.fromJson(r)));


      listChefs = ro;
      chef = listChefs[0];
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
