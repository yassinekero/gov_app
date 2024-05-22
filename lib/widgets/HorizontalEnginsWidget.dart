import 'package:flutter/cupertino.dart';

class E extends StatefulWidget {
  const E({super.key});

  @override
  State<E> createState() => _EState();
}

class _EState extends State<E> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
/*
 SizedBox(
              height: 115,
              width: 900,
              child: Row(
                children: [
                  if (currentPage > 0)
                    TextButton(
                        onPressed: () =>
                            {_pageController.jumpToPage(currentPage - 1)},
                        child: Icon(Icons.arrow_back_ios)),
                  Expanded(
                    child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (i) {
                          setState(() {
                            currentPage = i;
                            _currentRangeValues = RangeValues(widget.minPos,
                                widget.minPos + enginSelected.longueur);
                          });
                        },
                        itemCount: Data.enginList.length,
                        itemBuilder: (ctx, i) {
                          final engin = Data.enginList[i];
                          return Column(
                            children: [
                              Text(engin.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              FittedBox(child: EnginWidget(Data.enginList[i]))
                            ],
                          );
                        }),
                  ),
                  if (currentPage < Data.enginList.length - 1)
                    TextButton(
                        onPressed: () =>
                            {_pageController.jumpToPage(currentPage + 1)},
                        child: Icon(Icons.arrow_forward_ios)),
                ],
              )),
*/
