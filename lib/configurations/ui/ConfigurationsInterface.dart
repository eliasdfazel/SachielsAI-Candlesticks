/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/22/23, 9:55 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:candlesticks/configurations/data/ConfigurationsDataStructure.dart';
import 'package:candlesticks/configurations/utils/Utils.dart';
import 'package:candlesticks/previews/data/previews_data_structure.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/utils/modifications/numbers.dart';
import 'package:candlesticks/utils/navigations/navigation_commands.dart';
import 'package:candlesticks/utils/ui/display.dart';
import 'package:candlesticks/utils/ui/system_bars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
class ConfigurationsInterfaceState extends State<ConfigurationsInterface> with TickerProviderStateMixin {

  User firebaseUser = FirebaseAuth.instance.currentUser!;

  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  Widget configurationOptions = Container();

  late AnimationController animationController;

  late Animation<Offset> offsetAnimation;

  /*
   * Start - Markets
   */
  DataSnapshot? marketsDataSnapshot;

  bool marketsVisibility = false;
  double marketsOpacity = 0.0;

  bool addMarketsVisibility = false;

  Widget marketsItemsPlaceholder = Container();

  /*
   * Start - Configured Markets
   */
  Widget configuredMarketsList = Container();

  String configuredMarkets = "";
  Color configuredMarketsColor = ColorsResources.dark;
  /*
   * End - Configured Markets
   */
  /*
   * End - Markets
   */

  /*
   * Start - Timeframes
   */
  DataSnapshot? timeframesDataSnapshot;

  bool timeframesVisibility = false;
  double timeframesOpacity = 0.0;

  bool addTimeframesVisibility = false;

  Widget timeframesItemsPlaceholder = Container();

  /*
   * Start - Configured Timeframes
   */
  Widget configuredTimeframesList = Container();

  String configuredTimeframes = "";
  Color configuredTimeframesColor = ColorsResources.dark;
  /*
   * End - Configured Timeframes
   */
  /*
   * End - Timeframes
   */

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    if (marketsVisibility) {

      hideMarketsPicker();

    } else {

      navigatePop(context);

    }

    return true;
  }

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    changeColor(ColorsResources.black, ColorsResources.black);

    animationController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 777),
        reverseDuration: const Duration(milliseconds: 555),
        animationBehavior: AnimationBehavior.preserve);

    offsetAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn
    ));

    retrieveMarkets();

    retrieveConfiguredMarkets();

    retrieveTimeframes();

    retrieveConfiguredMarkets();

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
                          visible: marketsVisibility,
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
                       * Start - Market Picker
                       */
                      Visibility(
                          visible: timeframesVisibility,
                          child: AnimatedOpacity(
                            opacity: timeframesOpacity,
                            duration: const Duration(milliseconds: 777),
                            child: InkWell(
                                onTap: () {

                                  hideTimeframesPicker();

                                },
                                child: timeframesItemsPlaceholder
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

                                        if (marketsVisibility) {

                                          updateConfiguredMarkets();

                                          hideMarketsPicker();

                                        } else if (timeframesVisibility) {

                                        } else {

                                          configureIt();

                                        }

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

          setupConfiguredTimeframes(),

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
  /*
   * Start - Configured Markets
   */
  void retrieveConfiguredMarkets() async {

    String firestorePath = "Sachiels/Candlesticks/Profiles/${firebaseUser.email}/${widget.previewsDataStructure.candlestickNameValue()}/Configurations";

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.doc(firestorePath).get();

    ConfigurationsDataStructure configurationsDataStructure = ConfigurationsDataStructure(documentSnapshot);

    configuredMarkets = configurationsDataStructure.configuredMarketsValue();

    updateConfiguredMarkets();

  }

  void updateConfiguredMarkets() {

    if (configuredMarkets.isNotEmpty) {

      List<Widget> configuredItems = [];

      configuredMarkets.split(",").forEach((element) {

        if (element.isNotEmpty) {

          configuredItems.add(configuredMarketsItems(element));

        }

      });

      setState(() {

        configuredMarketsList = ListView(
            padding: const EdgeInsets.only(left: 13),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: configuredItems
        );

      });

    }

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

                        SizedBox(
                            height: 53,
                            child: configuredMarketsList
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
  /*
   * End - Configured Markets
   */

  void retrieveMarkets() async {

    marketsDataSnapshot = await databaseReference.child("Candlesticks/Markets").get();
    debugPrint("Markets Data Retrieved");

    updateMarketsList();

  }

  void updateMarketsList() async {

    if (marketsDataSnapshot != null) {
      debugPrint("Updating Markets List");

      List<Widget> allMarketsItems = [];

      for (var element in marketsDataSnapshot!.children) {
        debugPrint("Market: ${element.key}");

        allMarketsItems.add(const Divider(height: 19, color: Colors.transparent));
        allMarketsItems.add(marketsPickerItemMarket(element.key.toString()));

        for(var marketPair in element.children) {
          debugPrint("Pair: ${marketPair.value}");

          allMarketsItems.add(marketsPickerItemPair(marketPair.key.toString(), marketPair.value.toString()));

        }

      }

      setState(() {

        marketsItemsPlaceholder = marketsPickerWrapper(allMarketsItems);

        addMarketsVisibility = true;

      });

    }

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
          child: SlideTransition(
            position: offsetAnimation,
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

    if (configuredMarkets.contains(marketLabel)) {

      configuredMarketsColor = ColorsResources.primaryColorLighter;

    } else {

      configuredMarketsColor = ColorsResources.dark;

    }

    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                  bottomLeft: Radius.circular(17),
                  bottomRight: Radius.circular(17)
              ),
              gradient: LinearGradient(
                  colors: [
                    configuredMarketsColor,
                    ColorsResources.black,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.13, 1.0],
                  transform: const GradientRotation(45),
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

                      configuredMarkets += "$marketLabel,";

                      updateMarketsList();

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

      marketsVisibility = true;

    });

    Future.delayed(const Duration(milliseconds: 137), () {

      animationController.forward();


      setState(() {

        marketsOpacity = 1.0;

      });

    });

  }

  void hideMarketsPicker() {

    animationController.reverse();

    setState(() {

      marketsOpacity = 0.0;

    });

    Future.delayed(const Duration(milliseconds: 777), () {

      setState(() {

        marketsVisibility = false;

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
   * Start - Configured Timeframes
   */
  void retrieveConfiguredTimeframes() async {

    String firestorePath = "Sachiels/Candlesticks/Profiles/${firebaseUser.email}/${widget.previewsDataStructure.candlestickNameValue()}/Configurations";

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.doc(firestorePath).get();

    ConfigurationsDataStructure configurationsDataStructure = ConfigurationsDataStructure(documentSnapshot);

    configuredTimeframes = configurationsDataStructure.configuredTimeframesValue();

    updateConfiguredTimeframes();

  }

  void updateConfiguredTimeframes() {

    if (configuredTimeframes.isNotEmpty) {

      List<Widget> configuredItems = [];

      configuredTimeframes.split(",").forEach((element) {

        if (element.isNotEmpty) {

          configuredItems.add(configuredTimeframesItems(element));

        }

      });

      setState(() {

        configuredTimeframesList = ListView(
            padding: const EdgeInsets.only(left: 13),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: configuredItems
        );

      });

    }

  }

  Widget setupConfiguredTimeframes() {

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
                                  child: Visibility(
                                      visible: addTimeframesVisibility,
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

                                                    showTimeframesPicker();

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

                        SizedBox(
                            height: 53,
                            child: configuredTimeframesList
                        )

                      ]
                  )
              )

            ]
        )
    );
  }

  Widget configuredTimeframesItems(String timeframe) {

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
   * End - Configured Timeframes
   */
  void retrieveTimeframes() async {

    timeframesDataSnapshot = await databaseReference.child("Candlesticks/Timeframes").get();
    debugPrint("Markets Data Retrieved");

    updateTimeframesList();

  }

  void updateTimeframesList() async {

    if (timeframesDataSnapshot != null) {
      debugPrint("Updating Timeframes List");

      List<Widget> allTimeframesItems = [];

      for (var element in timeframesDataSnapshot!.children) {
        debugPrint("Timeframe: ${element.key}");

        allTimeframesItems.add(timeframesPickerItemPair(element.key.toString(), element.value.toString()));

      }

      setState(() {

        timeframesItemsPlaceholder = marketsPickerWrapper(allTimeframesItems);

        addTimeframesVisibility = true;

      });

    }

  }

  Widget timeframesPickerItemPair(String timeframe, String description) {

    if (configuredTimeframes.contains(timeframe)) {

      configuredTimeframesColor = ColorsResources.primaryColorLighter;

    } else {

      configuredTimeframesColor = ColorsResources.dark;

    }

    return Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 5),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17)
                ),
                gradient: LinearGradient(
                    colors: [
                      configuredTimeframesColor,
                      ColorsResources.black,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.13, 1.0],
                    transform: const GradientRotation(45),
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

                          configuredTimeframes += "$timeframe,";

                          updateTimeframesList();

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
                                              "$timeframe | ",
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
                                                  description,
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

  void showTimeframesPicker() {

    setState(() {

      timeframesVisibility = true;

    });

    Future.delayed(const Duration(milliseconds: 137), () {

      animationController.forward();


      setState(() {

        timeframesOpacity = 1.0;

      });

    });

  }

  void hideTimeframesPicker() {

    animationController.reverse();

    setState(() {

      timeframesOpacity = 0.0;

    });

    Future.delayed(const Duration(milliseconds: 777), () {

      setState(() {

        timeframesVisibility = false;

      });

    });

  }
  /*
   * End - Timeframes
   */

  /*
   * Start - Update Firestore Candlestick
   */
  void configureIt() async {

    if (configuredMarkets.isNotEmpty
        && configuredTimeframes.isNotEmpty) {
      debugPrint("Configuring ${widget.previewsDataStructure.candlestickNameValue()} Notifications");

      List listOfConfiguredMarkets = configuredMarkets.split(",");
      listOfConfiguredMarkets.removeLast();

      List listOfConfiguredTimeframes = configuredTimeframes.split(",");
      listOfConfiguredTimeframes.removeLast();

      String firestorePath = "Sachiels/Candlesticks/Profiles/${firebaseUser.email}/${widget.previewsDataStructure.candlestickNameValue()}/Configurations";

      FirebaseFirestore.instance
          .doc(firestorePath)
          .set({
            "candlestickImage": widget.previewsDataStructure.candlestickImageValue(),
            "configuredMarkets": configuredMarkets,
            "configuredTimeframes": configuredTimeframes,
          });

      FirebaseFirestore.instance
          .doc("Sachiels/Candlesticks/Profiles/${firebaseUser.email}")
          .get().then((DocumentSnapshot documentSnapshot) {

            if (documentSnapshot.exists) {

              var listOfCandlesticks = documentSnapshot.get("ConfiguredCandlesticks") as List;
              debugPrint("Configured Candlesticks: $listOfCandlesticks");

              if (!listOfCandlesticks.contains(widget.previewsDataStructure.candlestickNameValue())) {

                listOfCandlesticks.add(widget.previewsDataStructure.candlestickNameValue());

                FirebaseFirestore.instance
                    .doc("Sachiels/Candlesticks/Profiles/${firebaseUser.email}")
                    .set({
                      "ConfiguredCandlesticks": listOfCandlesticks
                    });

              }

            }

          });

      for (var market in listOfConfiguredMarkets) {

        for (var timeframe in listOfConfiguredTimeframes) {
          debugPrint("Notification Topic: ${notificationTopic(widget.previewsDataStructure.candlestickNameValue(), timeframe, market)}");

          // FirebaseMessaging.instance.subscribeToTopic(notificationTopic(widget.previewsDataStructure.candlestickNameValue(), timeframe, market));

        }

      }

    }

  }
  /*
   * End - Update Firestore Candlestick
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
                    child: const Image(
                      image: AssetImage("assets/delete_icon.png"),
                    )
                )
            )
        )
    );
  }

}