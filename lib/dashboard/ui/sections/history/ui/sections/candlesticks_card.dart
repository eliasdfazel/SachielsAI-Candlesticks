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
import 'package:candlesticks/dashboard/ui/sections/history/data/HistoryDataStructure.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:url_launcher/url_launcher.dart';

class CandlesticksCard extends StatefulWidget {

  HistoryDataStructure historyDataStructure;

  CandlesticksCard({Key? key, required this.historyDataStructure}) : super(key: key);

  @override
  State<CandlesticksCard> createState() => _CandlesticksCardState();
}
class _CandlesticksCardState extends State<CandlesticksCard> {

  final flipController = FlipCardController();

  bool detailsCard = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 19),
      child: SizedBox(
        height: 117,
        width: 173,
        child: FlipCard(
            rotateSide: detailsCard ? RotateSide.left : RotateSide.right,
            onTapFlipping: true,
            axis: FlipAxis.vertical,
            controller: flipController,
            animationDuration: const Duration(milliseconds: 777),
            frontWidget: foregroundCard(),
            backWidget: backgroundCard()
        )
      )
    );
  }

  Widget foregroundCard() {

    return ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Material(
            shadowColor: Colors.transparent,
            color: Colors.transparent,
            child: InkWell(
                splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                splashFactory: InkRipple.splashFactory,
                onTap: () async {

                  launchUrl(Uri.parse(StringsResources.marketChartLink(widget.historyDataStructure.marketPairValue())), mode: LaunchMode.externalApplication);

                },
                child: Container(
                    color: ColorsResources.premiumDark.withOpacity(0.37),
                    child: Stack(
                        children: [

                          Center(
                              child: Image(
                                image: NetworkImage(widget.historyDataStructure.candlestickImageValue()),
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                              )
                          ),

                          /*
                           * Start - Information Icon
                           */
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
                                              onTap: () async {

                                                setState(() {

                                                  detailsCard = true;

                                                });

                                                await flipController.flipcard();

                                              },
                                              child: const Image(
                                                image: AssetImage("assets/data_icon.png"),
                                              )
                                          )
                                      )
                                  )
                              )
                          ),
                          /*
                           * end - Information Icon
                           */

                        ]
                    )
                )
            )
        )
    );
  }

  Widget backgroundCard() {

    return ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Material(
            shadowColor: Colors.transparent,
            color: Colors.transparent,
            child: InkWell(
                splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                splashFactory: InkRipple.splashFactory,
                onTap: () async {



                },
                child: Container(
                    color: ColorsResources.premiumDark.withOpacity(0.37),
                    child: Stack(
                        children: [

                          Center(
                              child: Image(
                                image: NetworkImage(widget.historyDataStructure.candlestickImageValue()),
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                              )
                          ),

                          Blur(
                            blur: 13,
                            borderRadius: BorderRadius.circular(13),
                            blurColor: ColorsResources.premiumDark,
                            colorOpacity: 0.37,
                            overlay: Padding(
                                padding: const EdgeInsets.all(19),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              widget.historyDataStructure.candlestickNameValue(),
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
                                              widget.historyDataStructure.marketDirectionValue(),
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

                                      const Divider(
                                        height: 19,
                                        color: Colors.transparent
                                      ),

                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(13),
                                              child: Container(
                                                  height: 37,
                                                  color: ColorsResources.premiumDark,
                                                  child: prepareMarkets()
                                              )
                                          )
                                      ),

                                      const Divider(
                                        height: 11,
                                        color: Colors.transparent
                                      ),

                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(13),
                                              child: Container(
                                                  height: 37,
                                                  color: ColorsResources.premiumDark,
                                                  child: prepareTimeframes()
                                              )
                                          )
                                      ),

                                    ]
                                )
                            ),
                            child: Container(),
                          ),

                          /*
                           * Start - Information Icon
                           */
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
                                              onTap: () async {

                                                setState(() {

                                                  detailsCard = false;

                                                });

                                                await flipController.flipcard();

                                              },
                                              child: const Image(
                                                image: AssetImage("assets/data_icon.png"),
                                              )
                                          )
                                      )
                                  )
                              )
                          ),
                          /*
                           * end - Information Icon
                           */

                        ]
                    )
                )
            )
        )
    );
  }

  /*
   * Start - Markets
   */
  Widget prepareMarkets() {



    return ListView(
        padding: const EdgeInsets.only(left: 7),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [

          configuredMarketsItems(widget.historyDataStructure.marketPairValue())

        ]
    );
  }

  Widget configuredMarketsItems(String marketPair) {

    return Padding(
        padding: const EdgeInsets.only(right: 13),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 23,
            width: 59,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        color: ColorsResources.premiumLight,
                        width: 1
                    ),
                    color: ColorsResources.premiumDark
                ),
                height: 23,
                width: 59,
                child: Center(
                    child: Text(
                      marketPair,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorsResources.premiumLight
                      ),
                    )
                )
            ),
          ),
        )
    );
  }
  /*
   * Start - Markets
   */

  /*
   * Start - Timeframes
   */
  Widget prepareTimeframes() {

    return ListView(
        padding: const EdgeInsets.only(left: 7),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [

          configuredTimeframesItems(widget.historyDataStructure.timeframeValue())

        ]
    );
  }

  Widget configuredTimeframesItems(String timeframe) {

    return Padding(
        padding: const EdgeInsets.only(right: 13),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 23,
            width: 59,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        color: ColorsResources.premiumLight,
                        width: 1
                    ),
                    color: ColorsResources.premiumDark
                ),
                height: 23,
                width: 59,
                child: Center(
                    child: Text(
                      timeframe,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorsResources.premiumLight
                      ),
                    )
                )
            ),
          ),
        )
    );
  }
  /*
   * End - Timeframes
   */

}