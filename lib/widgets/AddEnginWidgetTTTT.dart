import 'package:flutter/material.dart';
import 'package:gov/Data.dart';
import 'package:gov/models/VoieTTTTT.dart';
import 'package:gov/models/VoieSide.dart';

class AddEnginWidgetTTTTT extends StatefulWidget {
  const AddEnginWidgetTTTTT(this.voie,this.voieSide, {super.key});

  final VoieSide voieSide;
  final VoieTTTT voie;

  @override
  State<AddEnginWidgetTTTTT> createState() => _AddEnginWidgetTTTTTState();
}

class _AddEnginWidgetTTTTTState extends State<AddEnginWidgetTTTTT> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 115,
              width: 900,
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: Data.enginList.length,
                  itemBuilder: (ctx, i) {
                    final engin = Data.enginList[i];

                    return Column(
                      children: [
                        Text(engin.name,
                            style: Theme.of(context).textTheme.titleMedium),
                      //  FittedBox(child: Data.enginList[i].getWidget())
                      ],
                    );
                  })),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Container(
                width: 300,
                child: TextField( textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white54,
                      prefix: Icon(Icons.bookmark),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      label: Text("Motif")),
                ),
              ),
              Spacer(),
              Container(
                  width: 300,
                  child:  TextField( textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white54,
                        prefix: Icon(Icons.date_range),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        label: Text("Prévision de sortie")),
                  ))
            ]),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
