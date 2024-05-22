import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/ROLES.dart';
import 'package:gov/models/json_responses/GetTokenResponse.dart';
import 'package:gov/pages/AddUser.dart';
import 'package:gov/pages/VoiePage.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QR_Scanner extends StatefulWidget {
  const QR_Scanner({Key? key}) : super(key: key);

  @override
  State<QR_Scanner> createState() => _QR_ScannerState();
}

class _QR_ScannerState extends State<QR_Scanner> {

  String matricule = "", password = "";
  String? msg;


  @override
  Widget build(BuildContext context) {
    bool read = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel_outlined, size: 50.0,),color: Colors.white,)
        ],
      ),
      extendBodyBehindAppBar: true,
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          facing: CameraFacing.front,
          torchEnabled: true,
        ),
        onDetect: (capture) async {
          if(!read) {
            read = true;
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              matricule = barcode.rawValue!;
            }
            final tokenRes =
            await Data.getTokenMatricule(matricule)
                .onError((error, stackTrace) =>
                GetTokenResponse(
                    status: "error",
                    message: error.toString()));

            msg = tokenRes.message;

            if (tokenRes.status == "ok") {
              Data.token = tokenRes.token!;
              Data.currentUserID = tokenRes.user!.id!;
              Data.currentUserRole = ROLES.getRoleByKey(
                  tokenRes.user!.role_key);

              //  Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_ctx) =>
                    Data.currentUserRole == ROLES.ADMIN ? AddUser() : VoiePage(tokenRes.user!)),
              );
            }
          }
        },
      ),
    );;
  }
}
