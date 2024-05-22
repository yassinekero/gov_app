import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/Voie.dart';
import 'package:gov/pages/LoginPage.dart';
import 'package:gov/pages/VoiePage.dart';
import 'package:gov/widgets/AddEnginVoieVideSpaceWidget.dart';
import 'package:gov/widgets/VoieChangeInfoWidget.dart';

Future<void> main() async {

  await WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.top]);



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'GOV',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: Data.isTV?const VoiePage(null):const LoginPage(),
    );
  }
}


