/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/19/23, 10:37 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:candlesticks/configurations/data/ConfigurationsDataStructure.dart';
import 'package:candlesticks/configurations/utils/Utils.dart';
import 'package:candlesticks/dashboard/ui/sections/SachielsSignals.dart';
import 'package:candlesticks/dashboard/ui/sections/account_information_overview.dart';
import 'package:candlesticks/previews/data/previews_data_structure.dart';
import 'package:candlesticks/previews/ui/PreviewInterface.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/utils/modifications/numbers.dart';
import 'package:candlesticks/utils/navigations/navigation_commands.dart';
import 'package:candlesticks/utils/ui/display.dart';
import 'package:candlesticks/utils/ui/system_bars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../configurations/ui/ConfigurationsInterface.dart';

class DashboardInterface extends StatefulWidget {

  const DashboardInterface({Key? key}) : super(key: key);

  @override
  State<DashboardInterface> createState() => _DashboardInterfaceState();
}
class _DashboardInterfaceState extends State<DashboardInterface> {

  User firebaseUser = FirebaseAuth.instance.currentUser!;

  AccountInformationOverview accountInformationOverview = const AccountInformationOverview();

  Widget configuredCandlesticksPlaceholder = Container();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

    configuredCandlesticksPlaceholder = waiting();

    retrieveConfiguredCandlesticks();

  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 777), () {

      FlutterNativeSplash.remove();

    });

    int gridColumnCount = (displayLogicalWidth(context) / 199).round();

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
                       * Start - Title
                       */
                      Padding(
                          padding: const EdgeInsets.fromLTRB(25, 177, 25, 7),
                          child: SizedBox(
                            height: 59,
                            width: displayLogicalWidth(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Expanded(
                                  flex: 7,
                                  child: SizedBox(
                                    height: 59,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        StringsResources.configuredCandlesticks(),
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
                                    )
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 59,
                                    child: InkWell(
                                      onTap: () {

                                      },
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                                        alignment: Alignment.centerRight,
                                        child: const Image(
                                          image: AssetImage("assets/search_icon.png"),
                                          height: 43,
                                        )
                                      )
                                    ),
                                  ),
                                )

                              ]
                            ),
                          )
                      ),
                      /*
                       * End - Title
                       */

                      /*
                       * Start - List
                       */
                      configuredCandlesticksPlaceholder,
                      /*
                       * End - List
                       */
                      /*
                       * End - Content
                       */

                      /*
                       * Start - Add
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
                              onTap: () async {

                                bool updateConfiguredList = await navigateTo(context, PreviewInterface());

                                if (updateConfiguredList) {

                                  retrieveConfiguredCandlesticks();

                                }

                                debugPrint("Updating? $updateConfiguredList");
                              },
                              child: const Image(
                                image: AssetImage("assets/add_icon.png"),
                              )
                            )
                          )
                        )
                      ),
                      /*
                       * End - Add
                       */

                      /* Start - Account Information Overview */
                      accountInformationOverview,
                      /* End - Account Information Overview */

                      /* Start - Purchase Plan Picker */
                      const Positioned(
                          right: 19,
                          top: 19,
                          child: SachielsSignals()
                      ),
                      /* End - Purchase Plan Picker */

                    ]
                )
            )
        )
    );
  }

  Widget waiting() {

    return Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              LoadingAnimationWidget.staggeredDotsWave(
                  colorOne: ColorsResources.premiumLight,
                  colorTwo: ColorsResources.primaryColor,
                  size: 73
              ),

              Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 19, right: 19, top: 19),
                      child: Text(
                        StringsResources.addCandlestick(),
                        style: const TextStyle(
                            fontSize: 19,
                            color: ColorsResources.premiumLightTransparent
                        ),
                      )
                  )
              )

            ]
        )
    );
  }

  /* Start - Configured List */
  void retrieveConfiguredCandlesticks() async {

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(configurationsCollectionPath(firebaseUser.email!))
      .get();

    prepareCandlesticksList(querySnapshot);

  }

  void prepareCandlesticksList(QuerySnapshot querySnapshot) async {

    List<Widget> allCandlesticks = [];

    for (var element in querySnapshot.docs) {

      allCandlesticks.add(candlestickItem(ConfigurationsDataStructure(element)));

    }

    int gridColumnCount = (displayLogicalWidth(context) / 199).round();

    setState(() {

      configuredCandlesticksPlaceholder = Padding(
          padding: const EdgeInsets.fromLTRB(19, 237, 19, 7),
          child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridColumnCount,
                childAspectRatio: 0.79,
                mainAxisSpacing: 37.0,
                crossAxisSpacing: 19.0,
              ),
              padding: const EdgeInsets.fromLTRB(0, 19, 0, 137),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: scrollController,
              children: allCandlesticks
          )
      );

    });

  }

  Widget candlestickItem(ConfigurationsDataStructure configurationsDataStructure) {
    debugPrint("Configured Candlesticks: $configurationsDataStructure");

    return ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Material(
            shadowColor: Colors.transparent,
            color: Colors.transparent,
            child: InkWell(
                splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                splashFactory: InkRipple.splashFactory,
                onTap: () async {

                  DocumentSnapshot previewsDocument = await FirebaseFirestore.instance.doc(candlestickPreviewDocumentPath(configurationsDataStructure.candlestickNameValue())).get();

                  Future.delayed(const Duration(milliseconds: 531), () async {

                    bool updateConfiguredList = await navigateTo(context, ConfigurationsInterface(previewsDataStructure: PreviewsDataStructure(previewsDocument)));

                    if (updateConfiguredList) {

                      retrieveConfiguredCandlesticks();

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
                                image: NetworkImage(configurationsDataStructure.candlestickImageValue()),
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                              )
                          ),

                          Positioned(
                              bottom: 13,
                              left: 13,
                              right: 13,
                              child: PhysicalModel(
                                  color: Colors.transparent,
                                  elevation: 7,
                                  shadowColor: ColorsResources.black.withOpacity(0.37),
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
                                                      configurationsDataStructure.candlestickNameValue(),
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
                                                      configurationsDataStructure.candlestickMarketDirectionValue(),
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
                                    child: const SizedBox(
                                      height: 43,
                                    ),
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
  /* End - Configured List */

}
