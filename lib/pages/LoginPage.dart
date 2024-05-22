import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/ROLES.dart';
import 'package:gov/models/json_responses/GetTokenResponse.dart';
import 'package:gov/pages/AddUser.dart';
import 'package:gov/pages/VoiePage.dart';
import 'package:gov/pages/qr_scanner.dart';
import 'package:gov/services/TokenService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  String matricule = "", password = "";
  String? msg;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_ctx) => QR_Scanner()),
                      );
                    },
                    child: Image.asset(
                      "assets/images/Logo_ONCF.png",
                      width: 350,
                      height: 350,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 100),
                      TextField(
                        onChanged: (txt) => matricule = txt,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.perm_identity),
                          label: Text("Matricule"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        onChanged: (txt) => password = txt,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          label: Text("Mots de passe"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 25),
                      if (msg != null)
                        Text(
                          msg!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                      SizedBox(height: 25),
                      FilledButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                setState(() => isLoading = true);
                                final tokenRes = await Data.getToken(
                                        matricule, password)
                                    .onError((error, stackTrace) =>
                                        GetTokenResponse(
                                            status: "error",
                                            message: error.toString()));

                                msg = tokenRes.message;
                                print(msg);

                                if (tokenRes.status == "ok") {
                                  Data.token = tokenRes.token!;
                                  Data.currentUserID = tokenRes.user!.id!;
                                  Data.currentUserRole =
                                      ROLES.getRoleByKey(
                                          tokenRes.user!.role_key);

                                  // Save token to SharedPreferences
                                  TokenService tokenService = TokenService();
                                  await tokenService
                                      .saveToken(tokenRes.token!);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_ctx) =>
                                          Data.currentUserRole ==
                                                  ROLES.ADMIN
                                              ? AddUser()
                                              : VoiePage(tokenRes.user!),
                                    ),
                                  );
                                }

                                setState(() => isLoading = false);
                              },
                        child: isLoading
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 35),
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  child: const CircularProgressIndicator(),
                                ),
                              )
                            : Text(
                                "Se connecter",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
