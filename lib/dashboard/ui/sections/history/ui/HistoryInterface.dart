import 'package:candlesticks/dashboard/ui/sections/history/data/HistoryDataStructure.dart';
import 'package:candlesticks/dashboard/ui/sections/history/ui/sections/candlesticks_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryInterface extends StatefulWidget {

  HistoryInterface({Key? key}) : super(key: key);

  @override
  State<HistoryInterface> createState() => _HistoryInterfaceState();
}
class _HistoryInterfaceState extends State<HistoryInterface> with TickerProviderStateMixin {

  ScrollController scrollController = ScrollController();

  Widget contentPlaceholder = Container();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        height: 279,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(19))
        ),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
        child: contentPlaceholder
    );
  }

  /*
   * Start - Data
   */
  void retrieveCandlesticksHistory() async {

    FirebaseFirestore.instance
        .collection("Sachiels/Candlesticks/History")
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

        allHistory.add(CandlesticksCard(historyDataStructure: HistoryDataStructure(documentSnapshot)));

      }

    }

    setState(() {

      contentPlaceholder = Padding(
          padding: const EdgeInsets.fromLTRB(19, 37, 19, 0),
          child: ListView(
              padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              children: allHistory
          )
      );

    });

  }
  /*
   * End - Data
   */

}