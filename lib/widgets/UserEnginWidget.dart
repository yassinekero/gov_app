import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/ROLES.dart';
import 'package:gov/models/UserEngin.dart';
import 'package:gov/widgets/UserEnginEditWidget.dart';

class UserEnginWidget extends StatelessWidget {
  const UserEnginWidget(this.userEngin,
      {this.allowAddingUser = false,
      super.key,
      this.onTap,
      this.deleteFunction});

  final UserEngin userEngin;

  final void Function()? onTap;
  final void Function()? deleteFunction;
  final bool allowAddingUser;

  @override
  Widget build(BuildContext context) {
    final double opacity;
    Widget? txtEquipeWidget;
    Function()? onUserEnginClick;
    var user = userEngin.user;

    final Icon iconStatus;

    if (userEngin.status == null) {
      iconStatus = const Icon(Icons.help, size: 25, color: Colors.grey);
    } else if (!userEngin.status!) {
      iconStatus = const Icon(Icons.close, size: 25, color: Colors.red);
    } else {
      iconStatus = const Icon(Icons.done, size: 25, color: Colors.green);
    }

    if (Data.currentUserRole == ROLES.DUO) {
      if (userEngin.user.equipe != null &&
          userEngin.user.equipe!.atelier.duo_id == Data.currentUserID) {
        opacity = 1;

        txtEquipeWidget = Text("${userEngin.user.equipe?.name}");

        onUserEnginClick = () async {
          await openEditUserEnginDiag(context, user);
        };
      } else {
        opacity = 0.3;
      }
    } else if (Data.currentUserRole == ROLES.DPX) {
      if (userEngin.user.equipe != null &&
          userEngin.user.equipe!.dpx_id == Data.currentUserID) {
        opacity = 1;
        txtEquipeWidget = Text("${userEngin.user.equipe?.name}");
        onUserEnginClick = () async {
          await openEditUserEnginDiag(context, user);
        };
      } else {
        opacity = 0.3;
        txtEquipeWidget = Text("${userEngin.user.equipe?.name}");
      }
    } else {
      onUserEnginClick = () async {
        //await openEditUserEnginDiag(context, user);
        print(userEngin.tache);
        await openTache(context, userEngin);
      };
      opacity = 1;
    }

    final CircleAvatar imgUser;
    if (userEngin.user.img == null) {
      imgUser = const CircleAvatar(child: Icon(Icons.person));
    } else {
      imgUser = CircleAvatar(
        backgroundImage: NetworkImage(userEngin.user.img!),
      );
    }

    return Card(
      child: InkWell(
        onTap: onUserEnginClick,
        borderRadius: BorderRadius.circular(10),
        child: Opacity(
          opacity: opacity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(userEngin.user
                    .matricule), //FittedBox(child: Text(userEngin.user.name)),
                //subtitle: Text(userEngin.user.matricule),
                //leading: imgUser,
                iconStatus,
              ],
              //title: Text(userEngin.user.matricule),//FittedBox(child: Text(userEngin.user.name)),
              //subtitle: Text(userEngin.user.matricule),
              //leading: imgUser,
              //trailing: iconStatus,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openEditUserEnginDiag(context, user) async {
    bool? isDeleted = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
          title: Text("${user.name}(${user.matricule})",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          content: UserEnginEditWidget(userEngin)),
    );
    if (isDeleted ?? false) {
      deleteFunction!();
    }
  }
}

Future<void> openTache(context, user) async {
  bool? isDeleted = await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => AlertDialog(
        title:const Text("Tache",
            style:  TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        content: Text(user.tache)),
  );
  
}
