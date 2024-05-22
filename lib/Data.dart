import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gov/models/Atelier.dart';
import 'package:gov/models/CheckTechHabilite.dart';
import 'package:gov/models/Engin.dart';
import 'package:gov/models/EnginAtelier.dart';
import 'package:gov/models/EnginComposition.dart';
import 'package:gov/models/EnginSerie.dart';
import 'package:gov/models/Equipe.dart';
import 'package:gov/models/ROLES.dart';
import 'package:gov/models/Role.dart';
import 'package:gov/models/User.dart';
import 'package:gov/models/UserEngin.dart';
import 'package:gov/models/Voie.dart';
import 'package:gov/models/VoieEngin.dart';
import 'package:gov/models/json_responses/AddEnginResponse.dart';
import 'package:gov/models/json_responses/GetTokenResponse.dart';
import 'package:gov/pages/AddAtelier.dart';
import 'package:gov/pages/AddEquipe.dart';
import 'package:gov/pages/AddUser.dart';
import 'package:gov/pages/AddVoie.dart';
import 'package:gov/services/TokenService.dart';
import 'package:http/http.dart' as http;

import 'models/json_responses/AssignEnginResponse.dart';
import 'models/json_responses/UpdateVoieResponse.dart';

class Data {
  static String token = "";
  static ROLES currentUserRole = ROLES.AFF;
  static int currentUserID = -1;

  static const bool isTV = false;

  static List<Voie> listVoies = [];
  static String tokenTV  = "";
  static VoieEngin? tempVE;

  static final List<Engin> enginList = [
    Engin(
      id: 1,
      name: "ZM",
      longueur: 200,
      composition: [
        EnginComposition(489489, "RA", "V"),
        EnginComposition(489489, "RA", "V"),
        EnginComposition(489489, "RA", "V"),
      ],
    ),
    Engin(
      id: 1,
      name: "ZM1",
      longueur: 260,
      composition: [
        EnginComposition(595995, "M", "M"),
        EnginComposition(489489, "RA", "V"),
        EnginComposition(595995, "M", "M"),
      ],
    ),
    Engin(
        id: 1,
        name: "Z2M",
        composition: [
          EnginComposition(595995, "M", "M"),
          EnginComposition(489489, "RA", "V"),
          EnginComposition(595995, "RB", "V"),
          EnginComposition(595995, "M", "M"),
        ],
        longueur: 300),
    Engin(
        id: 1,
        name: "AM",
        composition: [
          EnginComposition(595995, "M", "M"),
          EnginComposition(489489, "RA", "V"),
          EnginComposition(595995, "RB", "V"),
          EnginComposition(595995, "RB", "V"),
          EnginComposition(595995, "RB", "V"),
          EnginComposition(595995, "M", "M"),
        ],
        longueur: 600)
  ];

  static const String hostUrl1 = "http://localhost:8000/v1";
  static const String hostUrl = "http://localhost:8000/v1";
  // static const String hostUrl = "http://localhost:8000/v1";

  static Future<List<Voie>> fetchVoies() async {
    TokenService tokenService = TokenService();
    String? token = await tokenService.getToken();

    final response = await http.get(
      Uri.parse('$hostUrl/voies'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Voie> voies =
          List<Voie>.from(l.map((modelVoie) => Voie.fromJson(modelVoie)));

      for (var voie in voies) {
        voie.VoieEngins.sort(
            (a, b) => a.position_voie.compareTo(b.position_voie));
      }
      return voies;
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<List<CheckTechHabilite>> getListCheckTechHabilite(
      int pour_coupure, int voie_id) async {
    final response = await dio.get(
        '$hostUrl/check_list_habilite?pour_coupure=$pour_coupure&voie_id=$voie_id',
        options: getReqOptions);

    print(response.data);
    if (response.statusCode == 200) {
      Iterable l = response.data;
      List<CheckTechHabilite> voies = List<CheckTechHabilite>.from(
          l.map((modelVoie) => CheckTechHabilite.fromJson(modelVoie)));

      return voies;
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<UpdateVoieResponse> updateVoieCheckListStatus(
      int check_tech_habilite_id, int voie_id, int status) async {
    TokenService tokenService = TokenService();
    String? token = await tokenService.getToken();

    final response = await dio.patch(
      '$hostUrl/voie_check_list?check_tech_habilite_id=$check_tech_habilite_id&voie_id=$voie_id&status=$status',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      UpdateVoieResponse assignEngin = UpdateVoieResponse.fromJson(data);
      return assignEngin;
    }

    throw Exception('Failed to load');
  }

  static Future<List<EnginSerie>> getEnginSeries() async {
    TokenService tokenService = TokenService();
    String? token = await tokenService.getToken();

    final response = await http.get(
      Uri.parse('$hostUrl/engin_series'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<EnginSerie> series = List<EnginSerie>.from(
          l.map((modelSerie) => EnginSerie.fromJson(modelSerie)));

      return series;
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<List<Engin>> getFreeEngins(int? serie_id) async {
    TokenService tokenService = TokenService();
    String? token = await tokenService.getToken();

    final response = await http.get(
      Uri.parse('$hostUrl/engins/free?serie_id=$serie_id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      Iterable l = json.decode(response.body);
      List<Engin> engins =
          List<Engin>.from(l.map((modelEngin) => Engin.fromJson(modelEngin)));

      return engins;
    } else {
      throw Exception('Failed to load');
    }
  }

  static final dio = Dio();

  static Future<AssignEnginResponse> addOrUpdateVoieEngin(
      VoieEngin voieEngin) async {
    TokenService tokenService = TokenService();
    String? token = await tokenService.getToken();

    var json = voieEngin.toJson();

    final response = await dio.post(
      '$hostUrl/voie_engins',
      data: jsonEncode(json),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      AssignEnginResponse assignEngin = AssignEnginResponse.fromJson(data);
      return assignEngin;
    }

    throw Exception('Failed to load');
  }

  static Future addUser(User user, BuildContext context) async {
    TokenService tokenService = TokenService();
    String? token = await tokenService.getToken();

    var json = user.toJson();

    final response = await dio.post(
      '$hostUrl/add_user',
      data: jsonEncode(json),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final supportedStatusCode = [200];
    if (supportedStatusCode.contains(response.statusCode)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 100,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Utilisateur ajouté avec succès',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton.extended(
                    label: Text('Fermer'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_ctx) => AddUser()),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 100,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Utilisateur non ajouté. Veuillez réessayer',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton.extended(
                    label: Text('Fermer'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  static Future addAtelier(Atelier atelier, BuildContext context) async {
    var json = atelier.toJson();

    final response = await dio.post('$hostUrl/add_atelier',
        data: jsonEncode(json), options: getReqOptions);

    final supportedStatusCode = [200];
    if (supportedStatusCode.contains(response.statusCode)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Atelier ajouté avec succès',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        label: Text('Fermer'),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_ctx) => AddAtelier()));
                        })
                  ],
                ),
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Atelier non ajouté. Veuillez réessayer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        label: Text('Fermer'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            );
          });
    }
  }

  static Future addVoie(Voie voie, BuildContext context) async {
    var json = voie.toJson();

    final response = await dio.post('$hostUrl/add_voie',
        data: jsonEncode(json), options: getReqOptions);

    final supportedStatusCode = [200];
    if (supportedStatusCode.contains(response.statusCode)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Voie ajoutée avec succès',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        label: Text('Fermer'),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_ctx) => AddVoie()));
                        })
                  ],
                ),
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Voie non ajoutée. Veuillez réessayer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        label: Text('Fermer'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            );
          });
    }
  }

  static Future addEquipe(Equipe atelier, BuildContext context) async {
    var json = atelier.toJson();

    final response = await dio.post('$hostUrl/add_equipe',
        data: jsonEncode(json), options: getReqOptions);

    final supportedStatusCode = [200];
    if (supportedStatusCode.contains(response.statusCode)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Equipe ajouté avec succès',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        label: Text('Fermer'),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_ctx) => AddEquipe()));
                        })
                  ],
                ),
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Equipe non ajouté. Veuillez réessayer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        label: Text('Fermer'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            );
          });
    }
  }

  static Future<CreateEnginResponse> createEngin(Engin engin) async {
    var json = engin.toJson();
/*
    json.remove("created_at");
    json.remove("deleted_at");
    json.remove("id");
    json.remove("engin");*/

    print(json);

    final response = await dio.post('$hostUrl/engins',
        data: jsonEncode(json), options: getReqOptions);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      CreateEnginResponse assignEngin = CreateEnginResponse.fromJson(data);
      return assignEngin;
/*
      if(assignEngin.status=="ok"){
        return assignEngin.voieEngin!;
      }*/
    }

    throw Exception('Failed to load');
  }

  static Future<UpdateVoieResponse> updateVoie(Voie voie) async {
    var json = voie.toJson();
/*
    json.remove("created_at");
    json.remove("deleted_at");
    json.remove("id");
    json.remove("engin");*/

    print(json);

    final response = await dio.patch('$hostUrl/voies',
        data: jsonEncode(json), options: getReqOptions);

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      UpdateVoieResponse assignEngin = UpdateVoieResponse.fromJson(data);
      return assignEngin;
    }

    throw Exception('Failed to load');
  }

  static Future<UpdateVoieResponse> updateVoieSousTension(Voie voie) async {
    var json = voie.toJson();

    print(json);

    final response = await dio.patch('$hostUrl/upadate_voie_tension',
        data: jsonEncode(json), options: getReqOptions);

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      UpdateVoieResponse assignEngin = UpdateVoieResponse.fromJson(data);
      return assignEngin;
    }

    throw Exception('Failed to load');
  }

  static Future<int> updateCompo(Engin engin) async {
    var json = [];
    for (var c in engin.composition) {
      json.add(c.toJson());
    }

    print(
        '-------------------------------------------------------------------------------------------------');
    print(json);
    print(
        '-------------------------------------------------------------------------------------------------');

    final response = await dio.patch(
        '$hostUrl/engins/compo/${engin.id}/${engin.longueur}',
        data: jsonEncode(json),
        options: getReqOptions);

    print("-----++++++ ${response.data}");

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      return response.statusCode ?? 404;
    }

    throw Exception('Failed to load');
  }

  static Future<List<EnginComposition>> getVoieEnginsUsers(
      int voieEnginId) async {
    final response =
        await http.get(Uri.parse('$hostUrl/voie_engins/$voieEnginId/users'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<EnginComposition> composants = List<EnginComposition>.from(
          l.map((modelVoie) => EnginComposition.fromJson(modelVoie)));

      return composants;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

  static Future<List<EnginAtelier>> getEnginAteliers(int voieEnginId) async {
    final response = await http
        .get(Uri.parse('$hostUrl/voie_engins/$voieEnginId/engin_ateliers'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<EnginAtelier> composants = List<EnginAtelier>.from(
          l.map((modelVoie) => EnginAtelier.fromJson(modelVoie)));

      return composants;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

  static get getReqOptions {
    return Options(
        headers: {"authorization": "Bearer $token"},
        contentType: "application/json",
        validateStatus: (f) {
          return true;
        });
  }

  static Future<AssignEnginResponse> deleteVoieEngin(int voieEnginId) async {
    final response = await dio.delete('$hostUrl/voie_engins?id=$voieEnginId',
        options: getReqOptions);

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      AssignEnginResponse assignEngin = AssignEnginResponse.fromJson(data);
      return assignEngin;
/*
      if(assignEngin.status=="ok"){
        return assignEngin.voieEngin!;
      }*/
    }

    throw Exception('Failed to load');
  }

  static Future<GetTokenResponse> getToken(
      String matricule, String password) async {
    final response = await dio.get(
        '$hostUrl/get_token?matricule=$matricule&password=$password',
        options: Options(
            contentType: "application/json",
            validateStatus: (f) {
              return true;
            }));

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      GetTokenResponse assignEngin = GetTokenResponse.fromJson(data);
      return assignEngin;
/*
      if(assignEngin.status=="ok"){
        return assignEngin.voieEngin!;
      }*/
    }

    throw Exception('Failed to load');
  }

  static Future<GetTokenResponse> getTokenMatricule(String matricule) async {
    final response =
        await dio.get('$hostUrl/get_token_matricule?matricule=$matricule',
            options: Options(
                contentType: "application/json",
                validateStatus: (f) {
                  return true;
                }));
    print(response.statusCode);
    print(matricule);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      print(data);
      GetTokenResponse assignEngin = GetTokenResponse.fromJson(data);
      return assignEngin;
/*
      if(assignEngin.status=="ok"){
        return assignEngin.voieEngin!;
      }*/
    }

    throw Exception('Failed to load');
  }

  static Future<User> getUserInfo() async {
    final response = await dio.get('$hostUrl/user_info?token=$token',
        options: Options(
            contentType: "application/json",
            validateStatus: (f) {
              return true;
            }));

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      User user = User.fromJson(data);
      return user;
/*
      if(assignEngin.status=="ok"){
        return assignEngin.voieEngin!;
      }*/
    }

    throw Exception('Failed to load');
  }

  static Future<List<User>> getAtelierUsers() async {
    //DUO
    final response =
        await dio.get('$hostUrl/ateliers/users', options: getReqOptions);

    if (response.statusCode == 200) {
      Iterable l = response.data;
      List<User> users =
          List<User>.from(l.map((modelUser) => User.fromJson(modelUser)));

      return users;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

  static Future<List<User>> getEquipesUsers() async {
    //DPX
    final response =
        await dio.get('$hostUrl/equipes/users', options: getReqOptions);

    if (response.statusCode == 200) {
      Iterable l = response.data;
      List<User> users =
          List<User>.from(l.map((modelUser) => User.fromJson(modelUser)));

      return users;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

  static Future<CreateEnginResponse> addUsersToCompositionEngin(
      List<User> users, int voieEnginId, int compositionId) async {
    var json = jsonEncode(users);
/*
    json.remove("created_at");
    json.remove("deleted_at");
    json.remove("id");
    json.remove("engin");*/

    print(json);

    final response = await dio.post(
        '$hostUrl/user_engins?voie_engin_id=$voieEnginId&composition_id=$compositionId',
        data: json,
        options: getReqOptions);

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      CreateEnginResponse assignEngin = CreateEnginResponse.fromJson(data);
      return assignEngin;
    }

    throw Exception('Failed to load');
  }

  static Future<CreateEnginResponse> addCurrentUserToUserEngin(
      int voieEnginId, int compositionId, bool status) async {
/*
    json.remove("created_at");
    json.remove("deleted_at");
    json.remove("id");
    json.remove("engin");*/

    print(json);

    final response = await dio.post(
        '$hostUrl/user_engins/add?voie_engin_id=$voieEnginId&composition_id=$compositionId&status=$status',
        options: getReqOptions);

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      CreateEnginResponse assignEngin = CreateEnginResponse.fromJson(data);
      return assignEngin;
    }

    throw Exception('Failed to load');
  }

  static Future<CreateEnginResponse> addCurrentUserToAllUserEngin(
      VoieEngin voieEngin, bool status) async {
    print(voieEngin.id);
    print(voieEngin.engin_id);
    try {
      // Fetch all compositions for the given voieEnginId
      final compositionsResponse = await dio.get(
          '$hostUrl/engins/${voieEngin.engin_id}/compositions',
          options: getReqOptions);

      if (compositionsResponse.statusCode != 200) {
        throw Exception('Failed to fetch compositions');
      }

      // Extract compositions from the response
      List compositions = compositionsResponse.data['compositions'];
      if (compositions == null || compositions.isEmpty) {
        throw Exception('No compositions found for the given voieEnginId');
      }

      // Initialize a variable to hold the final response
      CreateEnginResponse finalResponse = CreateEnginResponse("true");

      // Loop through each composition and add the current user
      for (var composition in compositions) {
        int compositionId = composition['id'];
        print(compositionId);
        final response = await dio.post(
            '$hostUrl/user_engins/add?voie_engin_id=${voieEngin.id}&composition_id=$compositionId&status=$status',
            options: getReqOptions);

        if (![200, 403, 400].contains(response.statusCode)) {
          throw Exception('Failed to add user to composition $compositionId');
        }

        var data = response.data;
        CreateEnginResponse assignEngin = CreateEnginResponse.fromJson(data);

        if (assignEngin.status != 'ok') {
          throw Exception('Failed to add user to composition $compositionId');
        }

        // Save the last successful response
        finalResponse = assignEngin;
      }

      // Return the final response
      return finalResponse;
    } catch (e) {
      print(e);
      throw Exception(
          'An error occurred while adding user to all compositions');
    }
  }

  static Future<UpdateVoieResponse> updateUserEngin(UserEngin userEngin) async {
    var json = userEngin.toJson();

    print(json);

    final response = await dio.patch('$hostUrl/user_engins',
        data: jsonEncode(json), options: getReqOptions);

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      UpdateVoieResponse assignEngin = UpdateVoieResponse.fromJson(data);
      return assignEngin;
    }

    throw Exception('Failed to load');
  }

  static Future<EnginAtelier> getEnginAtelierByDUOID(int voieEnginId) async {
    final response = await dio.get(
        '$hostUrl/engin_ateliers?voie_engin_id=$voieEnginId',
        options: getReqOptions);

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      EnginAtelier enginAtelier = EnginAtelier.fromJson(data);
      return enginAtelier;
/*
      if(assignEngin.status=="ok"){
        return assignEngin.voieEngin!;
      }*/
    }

    throw Exception('Failed to load');
  }

  static Future<UpdateVoieResponse> updateEnginAtelier(
      EnginAtelier enginAtelier) async {
    var json = enginAtelier.toJson();

    print(json);

    final response = await dio.patch('$hostUrl/engin_ateliers',
        data: jsonEncode(json), options: getReqOptions);

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      UpdateVoieResponse assignEngin = UpdateVoieResponse.fromJson(data);
      return assignEngin;
    }

    throw Exception('Failed to load');
  }

  static Future<UpdateVoieResponse> deleteUserEngin(int userEnginId) async {
    final response = await dio.delete('$hostUrl/user_engins?id=$userEnginId',
        options: getReqOptions);

    print(response.data);

    final supportedStatusCode = [403, 200, 400];
    if (supportedStatusCode.contains(response.statusCode)) {
      var data = response.data;
      UpdateVoieResponse assignEngin = UpdateVoieResponse.fromJson(data);
      return assignEngin;
/*
      if(assignEngin.status=="ok"){
        return assignEngin.voieEngin!;
      }*/
    }

    throw Exception('Failed to load');
  }

  static Future<dynamic> confirmVoieEngin(int voieEnginId) async {
    final response = await dio.patch(
        '$hostUrl/voie_engins/confirm/$voieEnginId',
        options: getReqOptions);

    print(response.data);

    final supportedStatusCode = [200];
    print(response.statusCode);
    if (supportedStatusCode.contains(response.statusCode)) {
      return true;
/*
      if(assignEngin.status=="ok"){
        return assignEngin.voieEngin!;
      }*/
    }

    throw Exception('Failed to load');
  }
}
