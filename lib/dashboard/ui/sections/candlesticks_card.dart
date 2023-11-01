/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/1/23, 9:57 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:candlesticks/configurations/data/ConfigurationsDataStructure.dart';
import 'package:candlesticks/configurations/ui/ConfigurationsInterface.dart';
import 'package:candlesticks/configurations/utils/Utils.dart';
import 'package:candlesticks/dashboard/ui/DashboardInterface.dart';
import 'package:candlesticks/previews/data/previews_data_structure.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/utils/navigations/navigation_commands.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CandlesticksCard extends StatefulWidget {

  DashboardInterfaceState dashboardInterfaceState;

  ConfigurationsDataStructure configurationsDataStructure;

  CandlesticksCard({Key? key, required this.dashboardInterfaceState, required this.configurationsDataStructure}) : super(key: key);

  @override
  State<CandlesticksCard> createState() => _CandlesticksCardState();
}
class _CandlesticksCardState extends State<CandlesticksCard> {

  double dataCardOpacity = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Configured Candlesticks: $widget.configurationsDataStructure");

    return ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Material(
            shadowColor: Colors.transparent,
            color: Colors.transparent,
            child: InkWell(
                splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                splashFactory: InkRipple.splashFactory,
                onTap: () async {

                  DocumentSnapshot previewsDocument = await FirebaseFirestore.instance.doc(candlestickPreviewDocumentPath(widget.configurationsDataStructure.candlestickNameValue())).get();

                  Future.delayed(const Duration(milliseconds: 531), () async {

                    bool updateConfiguredList = await navigateTo(context, ConfigurationsInterface(previewsDataStructure: PreviewsDataStructure(previewsDocument)));

                    if (updateConfiguredList) {

                      widget.dashboardInterfaceState.retrieveConfiguredCandlesticks();

                    }

                    debugPrint("Updating? $updateConfiguredList");

                  });

                },
                child: Container(
                    color: ColorsResources.premiumDark.withOpacity(0.37),
                    child: Stack(
                        children: [

                          Center(
                              child: Image(
                                image: NetworkImage(widget.configurationsDataStructure.candlestickImageValue()),
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                              )
                          ),

                          AnimatedOpacity(
                              opacity: dataCardOpacity,
                              duration: const Duration(milliseconds: 777),
                              child: Blur(
                                blur: 13,
                                borderRadius: BorderRadius.circular(13),
                                blurColor: ColorsResources.premiumDark,
                                colorOpacity: 0.37,
                                overlay: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  widget.configurationsDataStructure.candlestickNameValue(),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      color: ColorsResources.premiumLight,
                                                      fontSize: 17,
                                                      letterSpacing: 1.3,
                                                      fontWeight: FontWeight.bold
                                                  )
                                              )
                                          ),

                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  widget.configurationsDataStructure.candlestickMarketDirectionValue(),
                                                  textAlign: TextAlign.end,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      color: ColorsResources.premiumLight,
                                                      fontSize: 7,
                                                      letterSpacing: 1.3,
                                                      fontWeight: FontWeight.normal
                                                  )
                                              )
                                          ),

                                        ]
                                    )
                                ),
                                child: Container(),
                              )
                          ),

                          Positioned(
                              bottom: 13,
                              right: 13,
                              child: SizedBox(
                                  height: 31,
                                  width: 31,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(99),
                                      child: Material(
                                          shadowColor: Colors.transparent,
                                          color: Colors.transparent,
                                          child: InkWell(
                                              splashColor: ColorsResources.lightestYellow.withOpacity(0.73),
                                              splashFactory: InkRipple.splashFactory,
                                              onTap: () {

                                                setState(() {

                                                  if (dataCardOpacity == 0.0) {

                                                    dataCardOpacity = 1.0;

                                                  } else {

                                                    dataCardOpacity = 0.0;

                                                  }

                                                });

                                              },
                                              child: const Image(
                                                image: AssetImage("assets/data_icon.png"),
                                              )
                                          )
                                      )
                                  )
                              )
                          )

                        ]
                    )
                )
            )
        )
    );
  }

}