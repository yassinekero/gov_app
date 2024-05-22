import 'package:flutter/material.dart';
import 'package:gov/models/EnginTTT.dart';
import 'package:gov/models/EnginCompositionTTTTTTT.dart';
import 'package:gov/models/Person.dart';
import 'package:gov/models/TensionStatus.dart';
import 'package:gov/models/UO.dart';
import 'package:gov/models/VoieTTTTT.dart';
import 'package:gov/models/VoieSide.dart';
import 'package:gov/widgets/add_person_aff_widget.dart';
import 'package:gov/widgets/person_widget.dart';
import 'package:gov/widgets/voie_side_widgetTTTTTT.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listVoies = [
    VoieTTTT(10, true, true, false,
     /*   leftSide: VoieSide(
          estimmobilise: true,
          motif: "GVG",
          tensionStatus:
              TensionStatus(BT: true, HT: false, MAT: false, MT: true),
          uoStatus: UO(
              topLeft: false,
              topRight: true,
              bottomRight: false,
              bottomLeft: true),
          engin: Engin(
            name: "ZM14",
            color: Colors.orange,
            composition: [
              EnginComposition(
                  isMotrice: true,
                  identifient: "M",
                  color: Colors.red,
                  listPersonAffc: [
                    Person(
                        matricule: "49977",
                        name: "Darai Anas",
                        image: "https://randomuser.me/api/portraits/men/1.jpg"),
                    Person(matricule: "87878", name: "Abdelahi Aren"),
                    Person(
                        matricule: "88787",
                        name: "Selassie Rashidi",
                        image: "https://randomuser.me/api/portraits/men/2.jpg")
                  ]),
              EnginComposition(
                  isMotrice: false,
                  identifient: "M",
                  color: Colors.red,
                  listPersonAffc: []),
              EnginComposition(
                  isMotrice: false,
                  identifient: "M",
                  color: Colors.red,
                  listPersonAffc: []),
              EnginComposition(
                  isMotrice: true,
                  identifient: "M",
                  color: Colors.red,
                  listPersonAffc: []),
            ],
          ),
          sortirDate: "10:30",
        ),*/
        rightSide: VoieSide(
          estimmobilise: false,
          motif: "GVG",
          tensionStatus:
              TensionStatus(BT: false, HT: true, MAT: false, MT: true),
          uoStatus: UO(
              topLeft: true,
              topRight: false,
              bottomRight: false,
              bottomLeft: false),
          engin: EnginTT(
            name: "ZM09",
            color: Colors.yellow,
            composition: [
              EnginCompositionTTTTTTT(
                  isMotrice: true,
                  identifient: "M",
                  color: Colors.red,
                  listPersonAffc: [
                    Person(
                        matricule: "49977",
                        name: "Chinua Iniko",
                        image: "https://randomuser.me/api/portraits/men/3.jpg"),
                    Person(
                        matricule: "54878",
                        name: "Daren Negasi",
                        image: "https://randomuser.me/api/portraits/men/8.jpg"),
                  ]),
              EnginCompositionTTTTTTT(
                  isMotrice: false,
                  identifient: "M",
                  color: Colors.white,
                  listPersonAffc: []),
              EnginCompositionTTTTTTT(
                  isMotrice: false,
                  identifient: "M",
                  color: Colors.white,
                  listPersonAffc: []),
              EnginCompositionTTTTTTT(
                  isMotrice: true,
                  identifient: "M",
                  color: Colors.red,
                  listPersonAffc: []),
            ],
          ),
          sortirDate: "12:30",
        )),
    VoieTTTT(22, true, false, false,
        leftSide: VoieSide(
            estimmobilise: true,
            motif: "GVG",
            tensionStatus:
                TensionStatus(BT: true, HT: false, MAT: true, MT: false),
            uoStatus: UO(
                topLeft: false,
                topRight: false,
                bottomRight: true,
                bottomLeft: true),
            engin: EnginTT(
              name: "122",
              color: Colors.yellow,
              composition: [
                EnginCompositionTTTTTTT(
                    isMotrice: false,
                    identifient: "7878849",
                    color: Colors.red,
                    listPersonAffc: []),
                EnginCompositionTTTTTTT(
                    isMotrice: false,
                    identifient: "9594978",
                    color: Colors.white,
                    listPersonAffc: []),
                EnginCompositionTTTTTTT(
                    isMotrice: false,
                    identifient: "5932598",
                    color: Colors.white,
                    listPersonAffc: []),
                EnginCompositionTTTTTTT(
                    isMotrice: false,
                    identifient: "9589797",
                    color: Colors.white,
                    listPersonAffc: []),
                EnginCompositionTTTTTTT(
                    isMotrice: false,
                    identifient: "4848488",
                    color: Colors.white,
                    listPersonAffc: []),
                EnginCompositionTTTTTTT(
                    isMotrice: false,
                    identifient: "5929599",
                    color: Colors.red,
                    listPersonAffc: []),
              ],
            ),
            sortirDate: "18:00")),
    VoieTTTT(
      15,
      false,
      true,
      true,
      leftSide: VoieSide(
          estimmobilise: false,
          motif: "GVG",
          tensionStatus:
              TensionStatus(BT: false, HT: true, MAT: true, MT: true),
          uoStatus: UO(
              topLeft: true,
              topRight: false,
              bottomRight: false,
              bottomLeft: true),
          engin: EnginTT(name: "ZM10", color: Colors.lime, composition: [
            EnginCompositionTTTTTTT(
                isMotrice: true,
                identifient: "M",
                color: Colors.green,
                listPersonAffc: []),
            EnginCompositionTTTTTTT(
                isMotrice: false,
                identifient: "981917",
                color: Colors.green,
                listPersonAffc: []),
            EnginCompositionTTTTTTT(
                isMotrice: true,
                identifient: "M",
                color: Colors.green,
                listPersonAffc: []),
          ]),
          sortirDate: "14/02/23"),
      rightSide: VoieSide(
          estimmobilise: true,
          motif: "GVG",
          tensionStatus:
              TensionStatus(BT: true, HT: true, MAT: true, MT: false),
          uoStatus: UO(
              topLeft: true,
              topRight: true,
              bottomRight: true,
              bottomLeft: false),
          engin: EnginTT(name: "ZM07", composition: [
            EnginCompositionTTTTTTT(
                isMotrice: true,
                identifient: "M",
                color: Colors.green,
                listPersonAffc: []),
            EnginCompositionTTTTTTT(
                isMotrice: false,
                identifient: "788498",
                color: Colors.green,
                listPersonAffc: []),
            EnginCompositionTTTTTTT(
                isMotrice: true,
                identifient: "M",
                color: Colors.green,
                listPersonAffc: []),
          ]),
          sortirDate: "12:30"),
    ),
    VoieTTTT(12, true, false, false,
        leftSide: VoieSide(
            estimmobilise: true,
            motif: "GVG",
            tensionStatus:
                TensionStatus(BT: true, HT: false, MAT: true, MT: false),
            uoStatus: UO(
                topLeft: false,
                topRight: false,
                bottomRight: true,
                bottomLeft: true),
            engin: EnginTT(
              name: "ZM01",
              color: Colors.lightBlueAccent,
              composition: [
                EnginCompositionTTTTTTT(
                    isMotrice: true,
                    identifient: "M",
                    color: Colors.red,
                    listPersonAffc: []),
                EnginCompositionTTTTTTT(
                    isMotrice: false,
                    identifient: "V",
                    color: Colors.white,
                    listPersonAffc: []),
                EnginCompositionTTTTTTT(
                    isMotrice: true,
                    identifient: "M",
                    color: Colors.red,
                    listPersonAffc: []),
              ],
            ),
            sortirDate: "TNR15"),
        rightSide: VoieSide(
            estimmobilise: false,
            motif: "GVG",
            tensionStatus:
                TensionStatus(BT: false, HT: false, MAT: true, MT: true),
            uoStatus: UO(
                topLeft: true,
                topRight: false,
                bottomRight: true,
                bottomLeft: false),
            engin: EnginTT(name: "AM", color: Colors.yellow, composition: [
              EnginCompositionTTTTTTT(
                  isMotrice: true,
                  identifient: "M",
                  color: Colors.red,
                  listPersonAffc: []),
              EnginCompositionTTTTTTT(
                  isMotrice: false,
                  identifient: "V",
                  color: Colors.red,
                  listPersonAffc: []),
              EnginCompositionTTTTTTT(
                  isMotrice: true,
                  identifient: "M",
                  color: Colors.white,
                  listPersonAffc: []),
            ]),
            sortirDate: "21:30")),
  ];

  final videVoie = VoieSide(
    estimmobilise: false,
    motif: "???",
    tensionStatus: TensionStatus(BT: false, HT: false, MAT: false, MT: false),
    uoStatus: UO(
        topLeft: false, topRight: false, bottomRight: false, bottomLeft: false),

    sortirDate: "??:??",
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final spacerI = SizedBox(width: 10);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(listVoies.length, (index) {
              final voie = listVoies[index];
              final leftSide = voie.leftSide;
              final rightSide = voie.rightSide;

              return ExpansionTile(
                initiallyExpanded: false,
                tilePadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                title: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Row(children: [
                        VoieSideWidgetTTTT(voie,leftSide ?? videVoie),
                        if (rightSide != null) Spacer(),
                        if (rightSide != null)
                          VoieSideWidgetTTTT(voie,rightSide,
                              crossAxisAlignment: CrossAxisAlignment.end)
                      ]),
                    ),
                    Positioned.fill(
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Card(
                            color: voie.electrifiee ? Colors.red : Colors.green,
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (voie.electrifiee)
                                      Icon(
                                          voie.electrifiee
                                              ? Icons.flash_on
                                              : Icons.flash_off,
                                          size: 28,
                                          color: Colors.white),
                                    Text(voie.identifiant.toString(),
                                        style: textTheme.headlineMedium!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold))
                                  ]),
                            ),
                          )),
                    ),
                  ],
                ),
                childrenPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     /* if (leftSide != null)
                        AffectPersonsSideWidget(engin: leftSide.engin!),
                      Spacer(),
                      if (rightSide != null)
                        AffectPersonsSideWidget(
                            engin: rightSide.engin!, isRight: true),*/
                    ],
                  )
                ],
              );
            }),
          ),
        ));
  }
}
