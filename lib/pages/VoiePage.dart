import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/ROLES.dart';
import 'package:gov/models/User.dart';
import 'package:gov/models/Voie.dart';
import 'package:gov/pages/LoginPage.dart';
import 'package:gov/widgets/AddEnginVoieVideSpaceWidget.dart';
import 'package:gov/widgets/DialogCheckTechHabilite.dart';
import 'package:gov/widgets/VoieChangeInfoWidget.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:carousel_slider/carousel_slider.dart';

class VoiePage extends StatefulWidget {
  const VoiePage(this.currentUser, {super.key});

  @override
  State<VoiePage> createState() => _VoiePageState();

  final User? currentUser;
}

class _VoiePageState extends State<VoiePage> {
  List<Voie> listVoies = [
    /*Voie(
        id: 15,
        longueur: 1200,
        electrifiee: true,
        hors_service: false,
        sous_tension: true,
        VoieEngins: [
          VoieEngin(
              id: 1,
              motif: "GVG",
              prevision_sortie: "11:20",
              position_voie: 200,
              basset: true,
              coactivite: true,
              estimmobilise: false,
              hautet: false,
              miseaterre: true,
              moyennet: true,
              engin: Engin(
                  id: 1,
                  name: "Z2M",
                  composition: [
                    EnginComposition(595995, "M", "M"),
                    EnginComposition(489489, "RA", "V"),
                    EnginComposition(595995, "RB", "V"),
                    EnginComposition(595995, "M", "M"),
                  ],
                  longueur: 300)),
          VoieEngin(
              id: 2,
              motif: "MT",
              prevision_sortie: "8:00",
              position_voie: 600,
              basset: false,
              coactivite: false,
              estimmobilise: false,
              hautet: true,
              miseaterre: true,
              moyennet: true,
              engin: Engin(
                id: 1,
                name: "ZM",
                longueur: 260,
                composition: [
                  EnginComposition(595995, "M", "M"),
                  EnginComposition(489489, "RA", "V"),
                  EnginComposition(595995, "M", "M"),
                ],
              )),
          VoieEngin(
              id: 3,
              motif: "GVG",
              prevision_sortie: "10:12",
              position_voie: 860,
              basset: false,
              coactivite: true,
              estimmobilise: false,
              hautet: true,
              miseaterre: false,
              moyennet: false,
              engin: Engin(
                id: 1,
                name: "ZM",
                longueur: 200,
                composition: [
                  EnginComposition(489489, "RA", "V"),
                  EnginComposition(489489, "RA", "V"),
                  EnginComposition(489489, "RA", "V"),
                ],
              )),
        ]),
    Voie(
        id: 22,
        longueur: 1000,
        electrifiee: true,
        hors_service: false,
        sous_tension: true,
        VoieEngins: [
          VoieEngin(
              id: 1,
              motif: "LP",
              prevision_sortie: "12:20",
              position_voie: 0,
              basset: true,
              coactivite: false,
              estimmobilise: true,
              hautet: true,
              miseaterre: true,
              moyennet: true,
              engin: Engin(
                  id: 1,
                  name: "Z2M",
                  composition: [
                    EnginComposition(595995, "M", "M"),
                    EnginComposition(489489, "RA", "V"),
                    EnginComposition(595995, "RB", "V"),
                    EnginComposition(595995, "M", "M"),
                  ],
                  longueur: 300)),
          VoieEngin(
              id: 1,
              motif: "GVG",
              prevision_sortie: "10:12",
              position_voie: 0400,
              basset: true,
              coactivite: true,
              estimmobilise: false,
              hautet: true,
              miseaterre: true,
              moyennet: false,
              engin: Engin(
                  id: 1,
                  name: "Z2M",
                  composition: [
                    EnginComposition(489489, "RA", "V"),
                    EnginComposition(595995, "RB", "V"),
                    EnginComposition(489489, "RA", "V"),
                    EnginComposition(595995, "RB", "V"),
                    EnginComposition(489489, "RA", "V"),
                  ],
                  longueur: 500)),
        ]),*/
  ];
  List<Voie> listVoies1 = [];
  List<Voie> listVoies2 = [];
  
  _futureExecute() async {
    var then = Data.fetchVoies().then((value) async {
      setState(() {
        Data.listVoies = value;
        listVoies = value;
        listVoies1 = listVoies.where((element) => element.type != 'Maintenance').toList();
        listVoies1 = listVoies1.reversed.toList();
        listVoies2 = listVoies.where((element) => element.type == 'Maintenance').toList();
        listVoies2 = listVoies2.reversed.toList();
      });
      if (Data.isTV) {
        await Future.delayed(const Duration(seconds: 10));
        _futureExecute();
      }
    });
  }

  User? currentUser;

  @override
  void initState() {
    _futureExecute();

    if (!Data.isTV)
      Data.getUserInfo().then((value) => setState(() => currentUser = value));

    super.initState();
  }

  List<String> days = [
    "lundi",
    "mardi",
    "mercredi",
    "jeudi",
    "vendredi",
    "samedi",
    "dimanche"
  ];

  List<String> daysAr = [
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
    "السبت",
    "الأحد"
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var dateTimeNow = DateTime.now();
    final jHijri = JHijri(fDate: DateTime.now());

    final voieItemHeight = Data.isTV
        ? (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                100) /
            6
        : null;
    return Scaffold(
        appBar: Data.isTV
            ? AppBar(
                toolbarHeight: 90,
                backgroundColor: const Color(0xff7a83f6),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                            "${days[dateTimeNow.weekday - 1].toUpperCase()} ${dateTimeNow.day.toString().padLeft(2, '0')}-${dateTimeNow.month.toString().padLeft(2, '0')}-${dateTimeNow.year.toString()}",
                            style: textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(
                            "${dateTimeNow.hour.toString().padLeft(2, '0')} : ${dateTimeNow.minute.toString().padLeft(2, '0')}",
                            style: textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Spacer(),
                    Material(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xffdadade)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                              "Technicentre de Maintenance des Rames de Kenitra",
                              style: textTheme.headlineMedium!.copyWith(
                                  color: const Color(0xff7078e1),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                            "${daysAr[dateTimeNow.weekday - 1].toUpperCase()} ${jHijri.day.toString().padLeft(2, '0')} ${jHijri.monthName} ${jHijri.year.toString()}",
                            style: textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(
                            "${dateTimeNow.hour.toString().padLeft(2, '0')} : ${dateTimeNow.minute.toString().padLeft(2, '0')}",
                            style: textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              )
            : AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                // leadingWidth: 300,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: _futureExecute,
                      icon: const Icon(Icons.refresh))
                ],

                //title: Text(widget.title),
                title: currentUser == null
                    ? null
                    : PopupMenuButton(
                        offset: Offset(0, 50),
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            child: Text("Se déconnecter"),
                            onTap: (){
                              Navigator.pop(context);
                              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_ctx) => LoginPage()));
                            },
                          )
                          //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        ],
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 5),
                            /*CircleAvatar(
                              backgroundImage: NetworkImage(currentUser!.img!),
                            ),
                            const SizedBox(width: 10),*/
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentUser!.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(
                                    (currentUser!.role == null)
                                        ? currentUser!.role_key
                                        : currentUser!.role!.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(color: Colors.black87)),
                              ],
                            )
                          ],
                        ),
                      ),
              ),
        body: SingleChildScrollView(
          child: Transform.scale(
            /*scaleX: Data.isTV
                ? (MediaQuery.of(context).size.width - 100) / 1200
                : 1,*/
            /* scaleY: Data.isTV
                ? (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top-90) /
                    (6 * 100)
                : 1,*/
            scale: 1,
            filterQuality: FilterQuality.high,
            origin: const Offset(0, 0),
            alignment: Alignment.topLeft,
            child: Data.isTV ? Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        child: Text('Gare Kenitra',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        child: Text('Rabat',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                      )
                    ],
                  ),
                ),
                CarouselSlider(
                    items: [Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:List.generate(listVoies1.length, (index) {
                        final voie = listVoies1[index];

                        /*  int firstSpaceWidth=voie.VoieEngins[0].position_voie;

                      int nextPosition=voie.VoieEngins[0].position_voie
                          +voie.VoieEngins[0].engin.longueur;

                      int secondSpaceWidth=voie.VoieEngins[1].position_voie;

                      int nextSecondPosition=voie.VoieEngins[1].position_voie
                          +voie.VoieEngins[1].engin.longueur;*/

                        List<Widget> listVideSpaces = [];

                        print("voie +${voie.id}");

                        int lastEnginPos = 0;
                        for (int i = 0; i < voie.VoieEngins.length; i++) {
                          int firstSpaceWidth =
                              voie.VoieEngins[i].position_voie - lastEnginPos;

                          if (firstSpaceWidth > 10) {
                            listVideSpaces.add(AddEnginVoieVideSpaceWidget(
                              lastEnginPos.toDouble(),
                              firstSpaceWidth.toDouble(),
                              voie: voie,
                            ));

                            /*   listVideSpaces.add(Positioned(
                              bottom: 0,
                              left: lastEnginPos.toDouble() + 5,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () => {},
                                        child: Column(
                                          children: [
                                            SizedBox(height: 100),
                                            Container(
                                                height: 5,
                                                width: firstSpaceWidth.toDouble() - 10,
                                                color: Colors.blue)
                                          ],
                                        )),
                                    Text(
                                        voie.VoieEngins[i].position_voie.toString() +
                                            "m",
                                        style: Theme.of(context).textTheme.labelSmall)
                                  ])));*/
                          }

                          lastEnginPos = voie.VoieEngins[i].position_voie +
                              voie.VoieEngins[i].engin!.longueur;
                        }

                        int lastSpaceWidth = voie.longueur - lastEnginPos;

                        if (lastSpaceWidth > 10) {
                          listVideSpaces.add(AddEnginVoieVideSpaceWidget(
                            lastEnginPos.toDouble(),
                            lastSpaceWidth.toDouble(),
                            voie: voie,
                          ));

                          /*listVideSpaces.add(Positioned(
                            bottom: 0,
                            left: lastEnginPos.toDouble() + 5,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () => {},
                                      child: Column(
                                        children: [
                                          SizedBox(height: 100),
                                          Container(
                                              height: 5,
                                              width: lastSpaceWidth.toDouble() - 10,
                                              color: Colors.blue)
                                        ],
                                      )),
                                  Text(
                                      "${voie.longueur}m",
                                      style: Theme.of(context).textTheme.labelSmall)
                                ])));*/
                        }

                        return Container(
                          width: double.infinity,
                          height: voieItemHeight,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Opacity(
                              opacity: voie.hors_service ? 0.2 : 1,
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (Data.isTV)
                                      Container(
                                        height: 50,
                                        margin:
                                        const EdgeInsets.only(bottom: 30, right: 5),
                                        color: voie.sous_tension
                                            ? Colors.red
                                            : const Color(0xFF85F66A),
                                        width: 70,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                  voie.electrifiee
                                                      ? Icons.flash_on
                                                      : Icons.flash_off,
                                                  size: 28,
                                                  color: Colors.black),
                                              Text(voie.id.toString(),
                                                  style: textTheme.headlineSmall!
                                                      .copyWith(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold))
                                            ]),
                                      ),
                                    Stack(
                                      children: [
                                        Container(
                                          width: voie.longueur.toDouble(),
                                          height: Data.isTV ? 120 : 200, // HEIGHT CHANGED
                                          margin: const EdgeInsets.only(
                                              top: Data.isTV ? 10 : 80),
                                          child: Stack(
                                            children: [
                                              ...List.generate(voie.VoieEngins.length,
                                                      (i) {
                                                    var voieEngin = voie.VoieEngins[i];
                                                    return AddEnginVoieVideSpaceWidget(
                                                        voieEngin.position_voie.toDouble(),
                                                        voieEngin.engin!.longueur
                                                            .toDouble(),
                                                        voieEngin: voieEngin,
                                                        voie: voie);
                                                  }),
                                              ...listVideSpaces
                                            ],
                                          ),
                                        ),
                                        if (!Data.isTV)
                                          Positioned.fill(
                                            child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Card(
                                                      color: voie.sous_tension
                                                          ? Colors.red
                                                          : Colors.green,
                                                      elevation: 5,
                                                      child: InkWell(
                                                        borderRadius:
                                                        BorderRadius.circular(10),
                                                        onTap:
                                                        onVoieBtnStatusClick(voie),
                                                        child: Container(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                          child: Row(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              children: [
                                                                Icon(
                                                                    voie.electrifiee
                                                                        ? Icons.flash_on
                                                                        : Icons
                                                                        .flash_off,
                                                                    size: 28,
                                                                    color:
                                                                    Colors.white),
                                                                Text(voie.id.toString(),
                                                                    style: textTheme
                                                                        .headlineMedium!
                                                                        .copyWith(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold))
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                    if (voie.type != null)
                                                      Text(
                                                        voie.type!,
                                                        style: textTheme.labelLarge,
                                                      ),
                                                  ],
                                                )),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      ))),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:List.generate(listVoies2.length, (index) {
                          final voie = listVoies2[index];

                          /*  int firstSpaceWidth=voie.VoieEngins[0].position_voie;

                        int nextPosition=voie.VoieEngins[0].position_voie
                            +voie.VoieEngins[0].engin.longueur;

                        int secondSpaceWidth=voie.VoieEngins[1].position_voie;

                        int nextSecondPosition=voie.VoieEngins[1].position_voie
                            +voie.VoieEngins[1].engin.longueur;*/

                          List<Widget> listVideSpaces = [];

                          print("voie +${voie.id}");

                          int lastEnginPos = 0;
                          for (int i = 0; i < voie.VoieEngins.length; i++) {
                            int firstSpaceWidth =
                                voie.VoieEngins[i].position_voie - lastEnginPos;

                            if (firstSpaceWidth > 10) {
                              listVideSpaces.add(AddEnginVoieVideSpaceWidget(
                                lastEnginPos.toDouble(),
                                firstSpaceWidth.toDouble(),
                                voie: voie,
                              ));

                              /*   listVideSpaces.add(Positioned(
                                bottom: 0,
                                left: lastEnginPos.toDouble() + 5,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () => {},
                                          child: Column(
                                            children: [
                                              SizedBox(height: 100),
                                              Container(
                                                  height: 5,
                                                  width: firstSpaceWidth.toDouble() - 10,
                                                  color: Colors.blue)
                                            ],
                                          )),
                                      Text(
                                          voie.VoieEngins[i].position_voie.toString() +
                                              "m",
                                          style: Theme.of(context).textTheme.labelSmall)
                                    ])));*/
                            }

                            lastEnginPos = voie.VoieEngins[i].position_voie +
                                voie.VoieEngins[i].engin!.longueur;
                          }

                          int lastSpaceWidth = voie.longueur - lastEnginPos;

                          if (lastSpaceWidth > 10) {
                            listVideSpaces.add(AddEnginVoieVideSpaceWidget(
                              lastEnginPos.toDouble(),
                              lastSpaceWidth.toDouble(),
                              voie: voie,
                            ));

                            /*listVideSpaces.add(Positioned(
                              bottom: 0,
                              left: lastEnginPos.toDouble() + 5,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () => {},
                                        child: Column(
                                          children: [
                                            SizedBox(height: 100),
                                            Container(
                                                height: 5,
                                                width: lastSpaceWidth.toDouble() - 10,
                                                color: Colors.blue)
                                          ],
                                        )),
                                    Text(
                                        "${voie.longueur}m",
                                        style: Theme.of(context).textTheme.labelSmall)
                                  ])));*/
                          }

                          return Container(
                            width: double.infinity,
                            height: voieItemHeight,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Opacity(
                                opacity: voie.hors_service ? 0.2 : 1,
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (Data.isTV)
                                        Container(
                                          height: 50,
                                          margin:
                                          const EdgeInsets.only(bottom: 30, right: 5),
                                          color: voie.sous_tension
                                              ? Colors.red
                                              : const Color(0xFF85F66A),
                                          width: 70,
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                    voie.electrifiee
                                                        ? Icons.flash_on
                                                        : Icons.flash_off,
                                                    size: 28,
                                                    color: Colors.black),
                                                Text(voie.id.toString(),
                                                    style: textTheme.headlineSmall!
                                                        .copyWith(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold))
                                              ]),
                                        ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: voie.longueur.toDouble(),
                                            height: Data.isTV ? 120 : 200, // HEIGHT CHANGED
                                            margin: const EdgeInsets.only(
                                                top: Data.isTV ? 10 : 80),
                                            child: Stack(
                                              children: [
                                                ...List.generate(voie.VoieEngins.length,
                                                        (i) {
                                                      var voieEngin = voie.VoieEngins[i];
                                                      return AddEnginVoieVideSpaceWidget(
                                                          voieEngin.position_voie.toDouble(),
                                                          voieEngin.engin!.longueur
                                                              .toDouble(),
                                                          voieEngin: voieEngin,
                                                          voie: voie);
                                                    }),
                                                ...listVideSpaces
                                              ],
                                            ),
                                          ),
                                          if (!Data.isTV)
                                            Positioned.fill(
                                              child: Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Card(
                                                        color: voie.sous_tension
                                                            ? Colors.red
                                                            : Colors.green,
                                                        elevation: 5,
                                                        child: InkWell(
                                                          borderRadius:
                                                          BorderRadius.circular(10),
                                                          onTap:
                                                          onVoieBtnStatusClick(voie),
                                                          child: Container(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                            child: Row(
                                                                mainAxisSize:
                                                                MainAxisSize.min,
                                                                children: [
                                                                  Icon(
                                                                      voie.electrifiee
                                                                          ? Icons.flash_on
                                                                          : Icons
                                                                          .flash_off,
                                                                      size: 28,
                                                                      color:
                                                                      Colors.white),
                                                                  Text(voie.id.toString(),
                                                                      style: textTheme
                                                                          .headlineMedium!
                                                                          .copyWith(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold))
                                                                ]),
                                                          ),
                                                        ),
                                                      ),
                                                      if (voie.type != null)
                                                        Text(
                                                          voie.type!,
                                                          style: textTheme.labelLarge,
                                                        ),
                                                    ],
                                                  )),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    )
                      )], options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 6),
                )
                ),
              ],
            ) : Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        child: Text('Gare Kenitra',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        child: Text('Rabat',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10
                          ),),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:List.generate(listVoies.length, (index) {
                    final voie = listVoies.reversed.toList()[index];

                    /*  int firstSpaceWidth=voie.VoieEngins[0].position_voie;

                    int nextPosition=voie.VoieEngins[0].position_voie
                        +voie.VoieEngins[0].engin.longueur;

                    int secondSpaceWidth=voie.VoieEngins[1].position_voie;

                    int nextSecondPosition=voie.VoieEngins[1].position_voie
                        +voie.VoieEngins[1].engin.longueur;*/

                    List<Widget> listVideSpaces = [];

                    print("voie +${voie.id}");

                    int lastEnginPos = 0;
                    for (int i = 0; i < voie.VoieEngins.length; i++) {
                      int firstSpaceWidth =
                          voie.VoieEngins[i].position_voie - lastEnginPos;

                      if (firstSpaceWidth > 10) {
                        listVideSpaces.add(AddEnginVoieVideSpaceWidget(
                          lastEnginPos.toDouble(),
                          firstSpaceWidth.toDouble(),
                          voie: voie,
                        ));

                        /*   listVideSpaces.add(Positioned(
                            bottom: 0,
                            left: lastEnginPos.toDouble() + 5,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () => {},
                                      child: Column(
                                        children: [
                                          SizedBox(height: 100),
                                          Container(
                                              height: 5,
                                              width: firstSpaceWidth.toDouble() - 10,
                                              color: Colors.blue)
                                        ],
                                      )),
                                  Text(
                                      voie.VoieEngins[i].position_voie.toString() +
                                          "m",
                                      style: Theme.of(context).textTheme.labelSmall)
                                ])));*/
                      }

                      lastEnginPos = voie.VoieEngins[i].position_voie +
                          voie.VoieEngins[i].engin!.longueur;
                    }

                    int lastSpaceWidth = voie.longueur - lastEnginPos;

                    if (lastSpaceWidth > 10) {
                      listVideSpaces.add(AddEnginVoieVideSpaceWidget(
                        lastEnginPos.toDouble(),
                        lastSpaceWidth.toDouble(),
                        voie: voie,
                      ));

                      /*listVideSpaces.add(Positioned(
                          bottom: 0,
                          left: lastEnginPos.toDouble() + 5,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () => {},
                                    child: Column(
                                      children: [
                                        SizedBox(height: 100),
                                        Container(
                                            height: 5,
                                            width: lastSpaceWidth.toDouble() - 10,
                                            color: Colors.blue)
                                      ],
                                    )),
                                Text(
                                    "${voie.longueur}m",
                                    style: Theme.of(context).textTheme.labelSmall)
                              ])));*/
                    }

                    return Container(
                      width: double.infinity,
                      height: voieItemHeight,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Opacity(
                          opacity: voie.hors_service ? 0.2 : 1,
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (Data.isTV)
                                  Container(
                                    height: 50,
                                    margin:
                                    const EdgeInsets.only(bottom: 30, right: 5),
                                    color: voie.sous_tension
                                        ? Colors.red
                                        : const Color(0xFF85F66A),
                                    width: 70,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                              voie.electrifiee
                                                  ? Icons.flash_on
                                                  : Icons.flash_off,
                                              size: 28,
                                              color: Colors.black),
                                          Text(voie.id.toString(),
                                              style: textTheme.headlineSmall!
                                                  .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold))
                                        ]),
                                  ),
                                Stack(
                                  children: [
                                    Container(
                                      width: voie.longueur.toDouble(),
                                      height: Data.isTV ? 120 : 200, // HEIGHT CHANGED
                                      margin: const EdgeInsets.only(
                                          top: Data.isTV ? 10 : 80),
                                      child: Stack(
                                        children: [
                                          ...List.generate(voie.VoieEngins.length,
                                                  (i) {
                                                var voieEngin = voie.VoieEngins[i];
                                                return AddEnginVoieVideSpaceWidget(
                                                    voieEngin.position_voie.toDouble(),
                                                    voieEngin.engin!.longueur
                                                        .toDouble(),
                                                    voieEngin: voieEngin,
                                                    voie: voie);
                                              }),
                                          ...listVideSpaces
                                        ],
                                      ),
                                    ),
                                    if (!Data.isTV)
                                      Positioned.fill(
                                        child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Card(
                                                  color: voie.sous_tension
                                                      ? Colors.red
                                                      : Colors.green,
                                                  elevation: 5,
                                                  child: InkWell(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    onTap:
                                                    onVoieBtnStatusClick(voie),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                                voie.electrifiee
                                                                    ? Icons.flash_on
                                                                    : Icons
                                                                    .flash_off,
                                                                size: 28,
                                                                color:
                                                                Colors.white),
                                                            Text(voie.id.toString(),
                                                                style: textTheme
                                                                    .headlineMedium!
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                                if (voie.type != null)
                                                  Text(
                                                    voie.type!,
                                                    style: textTheme.labelLarge,
                                                  ),
                                              ],
                                            )),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ),
              ],
            ),
            ),
          ),
        );
  }

  void Function()? onVoieBtnStatusClick(Voie voie) {
    switch (Data.currentUserRole) {
      case ROLES.RCI:
        return () => {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: Text("Voie ${voie.id}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    content: VoieChangeInfoWidget(voie)),
              ).then((value) => _futureExecute())
            };
      case ROLES.DUO:
        break;
      case ROLES.DPX:
        break;
      case ROLES.TECH:
        break;
      case ROLES.ADMIN:
        break;

      case ROLES.TECH_HABILITE:
        return () => {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: Text(
                        "Vous êtes sur le point ${voie.sous_tension ? 'decouper' : 'd\'établir'} le courant (Voie ${voie.id})",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    content: DialogCheckTechHabilite(voie)),
              ).then((value) => _futureExecute())
            };
      case ROLES.AFF:
        break;
    }

    return null;
  }
}
