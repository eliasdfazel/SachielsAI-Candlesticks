/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/22/23, 9:55 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:candlesticks/previews/data/previews_data_structure.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/utils/modifications/numbers.dart';
import 'package:candlesticks/utils/navigations/navigation_commands.dart';
import 'package:candlesticks/utils/ui/display.dart';
import 'package:candlesticks/utils/ui/system_bars.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_mask/widget_mask.dart';

class ConfigurationsInterface extends StatefulWidget {

  PreviewsDataStructure previewsDataStructure;

  ConfigurationsInterface({Key? key, required this.previewsDataStructure}) : super(key: key);

  @override
  State<ConfigurationsInterface> createState() => ConfigurationsInterfaceState();
}
class ConfigurationsInterfaceState extends State<ConfigurationsInterface> {

  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  Widget configurationOptions = Container();

  /*
   * Start - Markets
   */
  bool marketVisibility = false;
  double marketsOpacity = 0.0;

  bool addMarketsVisibility = false;

  Widget marketsItemsPlaceholder = Container();
  /*
   * End - Markets
   */

  /*
   * Start - Timeframes
   */
  double timeframesOpacity = 0.0;

  Widget timeframesItemsPlaceholder = Container();
  /*
   * End - Timeframes
   */

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

    retrieveMarkets();

    //

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringsResources.applicationName(),
            color: ColorsResources.primaryColor,
            theme: ThemeData(
              fontFamily: 'Ubuntu',
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              }),
            ),
            home: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorsResources.black,
                body: Stack(
                    children: [

                      /* Start - Decorations */
                      /* Start - Gradient Background - Dark */
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17),
                              bottomLeft: Radius.circular(17),
                              bottomRight: Radius.circular(17)
                          ),
                          border: Border(
                              top: BorderSide(
                                color: ColorsResources.black,
                                width: 7,
                              ),
                              bottom: BorderSide(
                                color: ColorsResources.black,
                                width: 7,
                              ),
                              left: BorderSide(
                                color: ColorsResources.black,
                                width: 7,
                              ),
                              right: BorderSide(
                                color: ColorsResources.black,
                                width: 7,
                              )
                          ),
                          gradient: LinearGradient(
                              colors: [
                                ColorsResources.premiumDark,
                                ColorsResources.black,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              transform: GradientRotation(-45),
                              tileMode: TileMode.clamp
                          ),
                        ),
                      ),
                      /* End - Gradient Background - Dark */

                      /* Start - Branding Transparent */
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                            opacity: 0.1,
                            child: Transform.scale(
                                scale: 1.7,
                                child: const Image(
                                  image: AssetImage("assets/logo.png"),
                                )
                            )
                        ),
                      ),
                      /* End - Branding Transparent */

                      /* Start - Gradient Background - Golden */
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(17),
                                    topRight: Radius.circular(17),
                                    bottomLeft: Radius.circular(17),
                                    bottomRight: Radius.circular(17)
                                ),
                                gradient: RadialGradient(
                                  radius: 1.1,
                                  colors: <Color> [
                                    ColorsResources.primaryColorLighter.withOpacity(0.51),
                                    Colors.transparent,
                                  ],
                                  center: const Alignment(0.79, -0.87),
                                )
                            ),
                            child: SizedBox(
                              height: calculatePercentage(99, displayLogicalHeight(context)),
                              width: calculatePercentage(99, displayLogicalWidth(context)),
                            ),
                          )
                      ),
                      /* End - Gradient Background - Golden */

                      /* Start - Gradient Background - Dark */
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17),
                              bottomLeft: Radius.circular(17),
                              bottomRight: Radius.circular(17)
                          ),
                          border: Border(
                              top: BorderSide(
                                color: ColorsResources.black,
                                width: 7,
                              ),
                              bottom: BorderSide(
                                color: ColorsResources.black,
                                width: 7,
                              ),
                              left: BorderSide(
                                color: ColorsResources.black,
                                width: 7,
                              ),
                              right: BorderSide(
                                color: ColorsResources.black,
                                width: 7,
                              )
                          ),
                          gradient: LinearGradient(
                              colors: [
                                ColorsResources.premiumDark,
                                ColorsResources.black,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              transform: GradientRotation(-45),
                              tileMode: TileMode.clamp
                          ),
                        ),
                      ),
                      /* End - Gradient Background - Dark */

                      /* Start - Branding Transparent */
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                            opacity: 0.37,
                            child: Transform.scale(
                                scale: 1.7,
                                child: const Image(
                                  image: AssetImage("assets/sachiels_candlestick_logo.png"),
                                )
                            )
                        ),
                      ),
                      /* End - Branding Transparent */

                      /* Start - Gradient Background - Golden */
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(17),
                                    topRight: Radius.circular(17),
                                    bottomLeft: Radius.circular(17),
                                    bottomRight: Radius.circular(17)
                                ),
                                gradient: RadialGradient(
                                  radius: 1.1,
                                  colors: <Color> [
                                    ColorsResources.primaryColorLighter.withOpacity(0.51),
                                    Colors.transparent,
                                  ],
                                  center: const Alignment(0.79, -0.87),
                                )
                            ),
                            child: SizedBox(
                              height: calculatePercentage(99, displayLogicalHeight(context)),
                              width: calculatePercentage(99, displayLogicalWidth(context)),
                            ),
                          )
                      ),
                      /* End - Gradient Background - Golden */

                      /*
                       * Start - List Background
                       */
                      Padding(
                          padding: const EdgeInsets.fromLTRB(7, 137, 7, 7),
                          child: Opacity(
                              opacity: 0.73,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(17)),
                                  child: Image(
                                    image: const AssetImage("assets/roundangle_half.png"),
                                    width: displayLogicalWidth(context),
                                    fit: BoxFit.fill,
                                  )
                              )
                          )
                      ),
                      /*
                       * End - List Background
                       */
                      /* End - Decorations */

                      /*
                       * Start - Content
                       */
                      /*
                       * Start - Candlestick Information
                       */
                      Padding(
                          padding: const EdgeInsets.fromLTRB(25, 177, 25, 7),
                          child: SizedBox(
                            height: 159,
                            width: displayLogicalWidth(context),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Expanded(
                                      flex: 7,
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            SizedBox(
                                                height: 29,
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      widget.previewsDataStructure.candlestickNameValue(),
                                                      style: TextStyle(
                                                          color: ColorsResources.premiumLight,
                                                          fontSize: 23,
                                                          fontWeight: FontWeight.bold,
                                                          letterSpacing: 1.37,
                                                          shadows: [
                                                            Shadow(
                                                                color: ColorsResources.primaryColorLighter.withOpacity(0.19),
                                                                blurRadius: 13,
                                                                offset: const Offset(-3, 3)
                                                            )
                                                          ]
                                                      ),
                                                    )
                                                )
                                            ),

                                            SizedBox(
                                                height: 19,
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      "(${widget.previewsDataStructure.candlestickDirectionValue()})",
                                                      style: TextStyle(
                                                          color: ColorsResources.premiumLight,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.normal,
                                                          letterSpacing: 1.37,
                                                          shadows: [
                                                            Shadow(
                                                                color: ColorsResources.primaryColorLighter.withOpacity(0.19),
                                                                blurRadius: 13,
                                                                offset: const Offset(-3, 3)
                                                            )
                                                          ]
                                                      ),
                                                    )
                                                )
                                            ),

                                            SizedBox(
                                                height: 111,
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      widget.previewsDataStructure.candlestickDescriptionValue(),
                                                      maxLines: 7,
                                                      textAlign: TextAlign.justify,
                                                      style: TextStyle(
                                                          color: ColorsResources.premiumLightTransparent,
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.normal,
                                                          letterSpacing: 1.37,
                                                          overflow: TextOverflow.ellipsis,
                                                          shadows: [
                                                            Shadow(
                                                                color: ColorsResources.primaryColorLighter.withOpacity(0.19),
                                                                blurRadius: 13,
                                                                offset: const Offset(-3, 3)
                                                            )
                                                          ]
                                                      ),
                                                    )
                                                )
                                            ),

                                          ]
                                      )
                                  ),

                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          alignment: Alignment.centerRight,
                                          child: Transform.scale(
                                              scale: 1.73,
                                              child: Image(
                                                image: NetworkImage(widget.previewsDataStructure.candlestickImageValue()),
                                                fit: BoxFit.fill,
                                                alignment: Alignment.center,
                                              )
                                          )
                                      )
                                  )

                                ]
                            ),
                          )
                      ),
                      /*
                       * End - Candlestick Information
                       */

                      /*
                       * Start - List
                       */
                      setupConfigurationOptions(),
                      /*
                       * End - List
                       */

                      /*
                       * Start - Market Picker
                       */
                      Visibility(
                          visible: marketVisibility,
                          child: AnimatedOpacity(
                            opacity: marketsOpacity,
                            duration: const Duration(milliseconds: 777),
                            child: InkWell(
                              onTap: () {

                                hideMarketsPicker();

                              },
                              child: marketsItemsPlaceholder
                            ),
                          )
                      ),
                      /*
                       * End - Market Picker
                       */
                      /*
                       * End - Content
                       */

                      /*
                       * Start - Confirm
                       */
                      Positioned(
                          bottom: 37,
                          left: 19,
                          right: 19,
                          child: Center(
                              child: SizedBox(
                                  height: 49,
                                  width: 239,
                                  child: InkWell(
                                      onTap: () {



                                      },
                                      child: const Image(
                                        image: AssetImage("assets/confirm_icon.png"),
                                      )
                                  )
                              )
                          )
                      ),
                      /*
                       * End - Confirm
                       */

                      /* Start - Back */
                      Row(
                        children: [

                          /* Start - Back */
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(19, 19, 0, 0),
                                  child: SizedBox(
                                      height: 59,
                                      width: 59,
                                      child: InkWell(
                                        onTap: () {

                                          navigatePop(context);

                                        },
                                        child: const Image(
                                          image: AssetImage("assets/back_icon.png"),
                                        ),
                                      )
                                  )
                              )
                          ),
                          /* End - Back */

                          /* Start - Title */
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(19, 19, 0, 0),
                                  child: SizedBox(
                                      height: 59,
                                      width: 155,
                                      child: Stack(
                                        children: [
                                          WidgetMask(
                                            blendMode: BlendMode.srcATop,
                                            childSaveLayer: true,
                                            mask /* Original Image */: Container(
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        ColorsResources.premiumDark,
                                                        ColorsResources.black,
                                                      ],
                                                      transform: GradientRotation(45)
                                                  )
                                              ),
                                            ),
                                            child: const Image(
                                              image: AssetImage("assets/rectircle_shape.png"),
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                  padding: const EdgeInsets.all(1.9),
                                                  child: WidgetMask(
                                                      blendMode: BlendMode.srcATop,
                                                      childSaveLayer: true,
                                                      mask /* Original Image */: Container(
                                                        decoration: const BoxDecoration(
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  ColorsResources.black,
                                                                  ColorsResources.premiumDark,
                                                                ],
                                                                transform: GradientRotation(45)
                                                            )
                                                        ),
                                                      ),
                                                      child: const Image(
                                                        image: AssetImage("assets/rectircle_shape.png"),
                                                      )
                                                  )
                                              )
                                          ),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                                  child: Text(
                                                      StringsResources.configuration(),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: ColorsResources.premiumLight,
                                                          fontSize: 19
                                                      )
                                                  )
                                              )
                                          )
                                        ],
                                      )
                                  )
                              )
                          ),
                          /* End - Title */

                        ],
                      ),
                      /* End - Back */

                      /* Start - Advanced */
                      Positioned(
                          right: 19,
                          top: 19,
                          child: SizedBox(
                              height: 59,
                              width: 59,
                              child: InkWell(
                                  onTap: () {

                                    Fluttertoast.showToast(
                                        msg: StringsResources.comingSoon(),
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: ColorsResources.premiumDark,
                                        textColor: ColorsResources.premiumLight,
                                        fontSize: 13.0
                                    );

                                  },
                                  child: const Image(
                                    image: AssetImage("assets/advanced_icon.png"),
                                  )
                              )
                          )
                      ),

                      Positioned(
                          right: 0,
                          top: 79,
                          child: SizedBox(
                              width: 99,
                              child: InkWell(
                                  onTap: () {

                                    Fluttertoast.showToast(
                                        msg: StringsResources.comingSoon(),
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: ColorsResources.premiumDark,
                                        textColor: ColorsResources.premiumLight,
                                        fontSize: 13.0
                                    );

                                  },
                                  child: const Image(
                                    image: AssetImage("assets/advanced_text.png"),
                                  )
                              )
                          )
                      ),
                      /* End - Advanced */

                    ]
                )
            )
        )
    );
  }

  Widget setupConfigurationOptions() {

    return configurationOptions = Padding(
      padding: const EdgeInsets.fromLTRB(25, 357, 25, 7),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 137),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [

          setupConfiguredMarkets(),

          const Divider(
            height: 19,
          ),

          //

          const Divider(
            height: 19,
          ),

          deleteConfiguration()

        ]
      )
    );
  }

  /*
   * Start - Markets
   */
  void retrieveMarkets() async {

    List<Widget> allMarketsItems = [];

    // Retrieve Markets
    // Visible + Button
    DataSnapshot marketsDataSnapshot = await databaseReference.child("SachielsSignals/Markets").get();
    debugPrint("Markets Data Retrieved");

    // one listView different item widget
    for (var element in marketsDataSnapshot.children) {
      debugPrint("Market: ${element.key}");

      allMarketsItems.add(const Divider(height: 19, color: Colors.transparent,));
      allMarketsItems.add(marketsPickerItemMarket(element.key.toString()));

      for(var marketPair in element.children) {
        debugPrint("Pair: ${marketPair.value}");

        allMarketsItems.add(marketsPickerItemPair(marketPair.key.toString(), marketPair.value.toString()));

      }

    }

    // Retrieve Selected Markets
    // Then setState for marketsItemsPlaceholder
    setState(() {

      marketsItemsPlaceholder = marketsPickerWrapper(allMarketsItems);

      addMarketsVisibility = true;

    });

  }

  Widget setupConfiguredMarkets() {

    return SizedBox(
        height: 93,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                  height: 33,
                  width: displayLogicalWidth(context) / 2,
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
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          StringsResources.markets(),
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
                                  child: Visibility(
                                    visible: addMarketsVisibility,
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(99),
                                          bottomLeft: Radius.circular(19),
                                          topRight: Radius.circular(19),
                                          topLeft: Radius.circular(19),
                                        ),
                                        child: Material(
                                            shadowColor: Colors.transparent,
                                            color: Colors.transparent,
                                            child: InkWell(
                                                splashColor: ColorsResources.primaryColor.withOpacity(0.51),
                                                splashFactory: InkRipple.splashFactory,
                                                onTap: () {

                                                  showMarketsPicker();

                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: const Image(
                                                      image: AssetImage("assets/plus_icon.png"),
                                                      height: 19,
                                                    )
                                                )
                                            )
                                        )
                                    )
                                  )
                              ),

                            ]
                        )

                      ]
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

  Widget configuredMarketsItems(String marketPair) {

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
                      marketPair,
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

  Widget marketsPickerWrapper(List<Widget> allMarketsItems) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(17),
              topRight: Radius.circular(17),
              bottomLeft: Radius.circular(17),
              bottomRight: Radius.circular(17)
          ),
        color: ColorsResources.premiumDark.withOpacity(0.73),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(19, 0, 19, 107),
          child: SizedBox(
              height: 357,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: ColoredBox(
                  color: ColorsResources.black,
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.fromLTRB(13, 3, 13, 19),
                      children: allMarketsItems
                  )
                )
              )
          )
        )
      )
    );
  }

  Widget marketsPickerItemMarket(String marketTitle) {

    return SizedBox(
        height: 37,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                    marketTitle,
                    maxLines: 1,
                    style: const TextStyle(
                        color: ColorsResources.primaryColorLightest,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.51
                    )
                )
            )
        )
    );
  }

  Widget marketsPickerItemPair(String marketLabel, String marketPair) {

    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 5),
      child: Container(
        decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                  bottomLeft: Radius.circular(17),
                  bottomRight: Radius.circular(17)
              ),
              gradient: LinearGradient(
                  colors: [
                    ColorsResources.dark,
                    ColorsResources.black,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.13, 1.0],
                  transform: GradientRotation(45),
                  tileMode: TileMode.clamp
              )
          ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Material(
                shadowColor: Colors.transparent,
                color: Colors.transparent,
                child: InkWell(
                    splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                    splashFactory: InkRipple.splashFactory,
                    onTap: () {



                    },
                    child: SizedBox(
                        height: 57,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 7, right: 7),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          "$marketLabel | ",
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: ColorsResources.premiumLight,
                                              fontSize: 23,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.fade
                                          )
                                      )
                                  ),

                                  Expanded(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            marketPair,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: ColorsResources.premiumLight,
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal,
                                                overflow: TextOverflow.fade
                                            )
                                        )
                                    )
                                  )

                                ]
                            )
                        )
                    )
                )
            )
        )
      )
    );
  }

  void showMarketsPicker() {

    setState(() {

      marketVisibility = true;

    });

    Future.delayed(const Duration(milliseconds: 137), () {

      setState(() {

        marketsOpacity = 1.0;

      });

    });

  }

  void hideMarketsPicker() {

    setState(() {

      marketsOpacity = 0.0;

    });

    Future.delayed(const Duration(milliseconds: 777), () {

      setState(() {

        marketVisibility = false;

      });

    });

  }
  /*
   * End - Markets
   */

  /*
   * Start - Timeframes
   */

  /*
   * End - Timeframes
   */

  Widget deleteConfiguration() {

    return Container(
        height: 57,
        alignment: Alignment.centerRight,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Material(
                shadowColor: Colors.transparent,
                color: Colors.transparent,
                child: InkWell(
                    splashColor: ColorsResources.red.withOpacity(0.73),
                    splashFactory: InkRipple.splashFactory,
                    onTap: () {

                      Future.delayed(const Duration(milliseconds: 333), () {



                      });

                    },
                    child: Image(
                      image: AssetImage("assets/delete_icon.png"),
                    )
                )
            )
        )
    );
  }

}