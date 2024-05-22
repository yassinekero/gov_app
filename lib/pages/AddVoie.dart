import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/Atelier.dart';
import 'package:gov/models/Voie.dart';
import 'package:gov/services/TokenService.dart';
import 'package:gov/widgets/NavigationDrawerAdmin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddVoie extends StatefulWidget {
  const AddVoie({Key? key}) : super(key: key);

  @override
  State<AddVoie> createState() => _AddVoieState();
}

class _AddVoieState extends State<AddVoie> {
  late Widget interface;
  TextEditingController codeController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  bool electrifiee = true;
  bool hors_service = false;
  bool sous_tension = true;
  late List<String> listType;
  late String type;

  @override
  void initState() {
    // TODO: implement initState
    interface = loading();
    super.initState();
  }

  Widget loading(){
    getTypesVoie();
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
                      controller: codeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        labelText: 'Code voie*',
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
                      controller: lengthController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        labelText: 'Longueur voie (m)*',
                        //errorText: prenomIsEmpty ? 'Entrez un prénom valide' : null
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Voie électrifiée'),
                        Checkbox(
                            value: electrifiee,
                            onChanged: (value){
                              electrifiee = value!;
                              setState(() {
                                interface = loaded();
                              });
                            })
                      ],
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
                        items: listType.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 60,
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                child: Text(value),
                              ),
                            ),
                          );
                        }).toList(),
                        value: type,
                        alignment: Alignment.center,
                        onChanged: (String? newval){
                          setState(() {
                            type = newval!;
                            interface = loaded();
                          });
                        },),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton.extended(
                      label: Text('Ajouter une voie'),
                      onPressed: (){
                        Voie voie = Voie(id: int.parse(codeController.text),type: type, longueur: int.parse(lengthController.text), electrifiee: electrifiee, VoieEngins: [], created_at: DateTime.now());
                        Data.addVoie(voie, context);
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

Future getTypesVoie() async {
  TokenService tokenService = TokenService();
  String? token = await tokenService.getToken();

  final response = await http.get(
    Uri.parse('${Data.hostUrl}/get_type_voie'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    dynamic r1 = json.decode(response.body);

    List<String> ro = List<String>.from(r1['types'].map((r) => r));

    listType = ro;
    type = listType[0];
    setState(() {
      interface = loaded();
    });
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

}
