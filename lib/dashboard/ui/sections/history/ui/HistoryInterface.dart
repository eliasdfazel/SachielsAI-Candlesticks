import 'package:candlesticks/dashboard/ui/sections/history/data/HistoryDataStructure.dart';
import 'package:candlesticks/dashboard/ui/sections/history/ui/sections/candlesticks_card.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/utils/modifications/texts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryInterface extends StatefulWidget {

  const HistoryInterface({Key? key}) : super(key: key);

  @override
  State<HistoryInterface> createState() => _HistoryInterfaceState();
}
class _HistoryInterfaceState extends State<HistoryInterface> with TickerProviderStateMixin {

  ScrollController scrollController = ScrollController();

  Widget contentPlaceholder = Container();

  bool historyVisibility = false;

  final int daysSevenMilliseconds = (86400000 * 7);

  @override
  void initState() {
    super.initState();

    retrieveCandlesticksHistory();

  }

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: historyVisibility,
      child: Container(
          height: 299,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 37),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(19))
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 19),
                    child: Text(
                      "${StringsResources.historyPreview()}${formatDateTime(DateTime.now().subtract(const Duration(days: 7)))}",
                      style: TextStyle(
                          color: ColorsResources.premiumLight,
                          fontSize: 23,
                          shadows: [
                            Shadow(
                                color: ColorsResources.primaryColorLighter.withOpacity(0.19),
                                blurRadius: 13,
                                offset: const Offset(-3, 3)
                            )
                          ]
                      ),
                    )
                ),

                contentPlaceholder

              ]
          )
      )
    );
  }

  /*
   * Start - Data
   */
  void retrieveCandlesticksHistory() async {

    FirebaseFirestore.instance
        .collection("Sachiels/Candlesticks/History/Timeframe/Daily")
        .orderBy(HistoryDataStructure.timestamp, descending: true)
        .get().then((QuerySnapshot querySnapshot) {

          if (querySnapshot.size > 0) {

            prepareHistoryList(querySnapshot.docs);

          }

        });

  }

  void prepareHistoryList(List<DocumentSnapshot> documentSnapshots) {

    List<Widget> allHistory = [];

    for (DocumentSnapshot documentSnapshot in documentSnapshots) {

      if (documentSnapshot.exists) {

        HistoryDataStructure historyDataStructure = HistoryDataStructure(documentSnapshot);

        int deltaTime = DateTime.now().millisecondsSinceEpoch - historyDataStructure.timestampValue().millisecondsSinceEpoch;

        if (deltaTime <= daysSevenMilliseconds) {

          allHistory.add(CandlesticksCard(historyDataStructure: historyDataStructure));

        }

      }

    }

    if (allHistory.isNotEmpty) {

      setState(() {

        historyVisibility = true;

      });

      Future.delayed(const Duration(milliseconds: 555), () {

        setState(() {

          contentPlaceholder = Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(31), topRight: Radius.circular(31), bottomLeft: Radius.circular(19), bottomRight: Radius.circular(19)),
                      child: ListView(
                          padding: const EdgeInsets.fromLTRB(10, 0, 19, 0),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          controller: scrollController,
                          shrinkWrap: true,
                          children: allHistory
                      )
                  )
              )
          );

        });

      });

    }

  }
  /*
   * End - Data
   */

}