/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/24/23, 7:13 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/utils/ui/display.dart';
import 'package:flutter/material.dart';

class Timeframes {

  /*
   * Start - Timeframes
   */
  Widget setupTimeframes(BuildContext context) {

    return SizedBox(
        height: 93,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                  height: 33,
                  width: displayLogicalWidth(context) / 2,
                  child: InkWell(
                      onTap: () {



                      },
                      child: Stack(
                          children: [

                            const Image(
                              image: AssetImage("assets/option_title_background.png"),
                            ),

                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Expanded(
                                      flex: 7,
                                      child: Container(
                                          padding: const EdgeInsets.only(left: 13),
                                          child: Text(
                                              StringsResources.timeframes(),
                                              style: const TextStyle(
                                                  color: ColorsResources.premiumLight,
                                                  fontSize: 15,
                                                  letterSpacing: 2.3
                                              )
                                          )
                                      )
                                  ),

                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: const Image(
                                            image: AssetImage("assets/plus_icon.png"),
                                            height: 19,
                                          )
                                      )
                                  ),

                                ]
                            )

                          ]
                      )
                  )
              ),

              SizedBox(
                  width: displayLogicalWidth(context) - 50,
                  child: Stack(
                      children: [

                        const Image(
                          image: AssetImage("assets/option_items_background.png"),
                        ),

                        // marketsItemsPlaceholder,

                        SizedBox(
                            height: 53,
                            child: ListView(
                                padding: const EdgeInsets.only(left: 13),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: [



                                ]
                            )
                        )

                      ]
                  )
              )

            ]
        )
    );
  }

  Widget timeframesItems(String timeframe) {

    return Padding(
        padding: const EdgeInsets.only(right: 13),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 31,
            width: 71,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        color: ColorsResources.premiumLight,
                        width: 1
                    ),
                    color: ColorsResources.premiumDark
                ),
                height: 33,
                width: 71,
                child: Center(
                    child: Text(
                      timeframe,
                      style: const TextStyle(
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