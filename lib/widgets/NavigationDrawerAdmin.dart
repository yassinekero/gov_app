import 'package:flutter/material.dart';
import 'package:gov/pages/AddAtelier.dart';
import 'package:gov/pages/AddEquipe.dart';
import 'package:gov/pages/AddUser.dart';
import 'package:gov/pages/AddVoie.dart';
import 'package:gov/pages/LoginPage.dart';


class NavigationDrawerAdmin extends StatelessWidget {
  const NavigationDrawerAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context), // , userProvider),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context){ //, UserProvider userProvider) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20, 50, 0, 50),
      child: InkWell(
        onTap: (){
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ADMIN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildMenuItems(BuildContext context) => Container(
    height: MediaQuery.of(context).size.height * 0.7,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Wrap(
            children: [
              ListTile(
                title: Text('Utilisateurs'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_ctx) => AddUser()));
                },
              ),
              ListTile(
                title: Text('Ateliers'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_ctx) => AddAtelier()));
                },
              ),
              ListTile(
                title: Text('Equipes'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_ctx) => AddEquipe()));
                },
              ),
              ListTile(
                title: Text('Voies'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_ctx) => AddVoie()));
                },
              ),
            ],
          ),
        ),
        Expanded(
          flex : 2,
          child: Container(),
        ),
        Expanded(
          flex: 1,
          child: ListTile(
            title: Text('Se déconnecter'),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_ctx) => LoginPage()));
            },
          ),
        ),
      ],
    ),
  );

}