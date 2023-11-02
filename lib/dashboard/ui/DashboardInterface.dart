/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/19/23, 10:37 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:candlesticks/configurations/data/ConfigurationsDataStructure.dart';
import 'package:candlesticks/configurations/utils/Utils.dart';
import 'package:candlesticks/dashboard/ui/sections/SachielsSignals.dart';
import 'package:candlesticks/dashboard/ui/sections/account_information_overview.dart';
import 'package:candlesticks/dashboard/ui/sections/candlesticks_card.dart';
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

class DashboardInterface extends StatefulWidget {

  const DashboardInterface({Key? key}) : super(key: key);

  @override
  State<DashboardInterface> createState() => DashboardInterfaceState();
}
class DashboardInterfaceState extends State<DashboardInterface> {

  User firebaseUser = FirebaseAuth.instance.currentUser!;

  AccountInformationOverview accountInformationOverview = const AccountInformationOverview();

  Widget configuredCandlesticksPlaceholder = Container();

  ScrollController scrollController = ScrollController();

  /*
   * Start - Search
   */
  List<ConfigurationsDataStructure> allCandlesticksData = [];

  TextEditingController searchController = TextEditingController();

  String? warningNoticeSearch;
  List<String> candlesticksNames = [];

  FocusNode searchFocusNode = FocusNode();

  bool searchBorderOpacity = false;

  String searchIcon = "assets/search_icon.png";
  double searchIconSize = 43;

  bool enableSearchInput = false;
  bool searchPerformed = false;
  /*
   * End - Search
   */

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
                          padding: const EdgeInsets.fromLTRB(13, 177, 25, 7),
                          child: SizedBox(
                            height: 59,
                            width: displayLogicalWidth(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Expanded(
                                  flex: 11,
                                  child: SizedBox(
                                    height: 59,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Stack(
                                        children: [

                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: AnimatedOpacity(
                                                opacity: searchBorderOpacity ? 1.0 : 0.0,
                                                duration: searchBorderOpacity ? const Duration(milliseconds: 1333) : const Duration(milliseconds: 555),
                                                curve: Curves.easeInOutCubic,
                                                child: const Image(
                                                  image: AssetImage("assets/gradient_border_ltr.png"),
                                                  height: 59,
                                                  fit: BoxFit.fill
                                                ),
                                              )
                                          ),

                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: AnimatedOpacity(
                                              opacity: searchBorderOpacity ? 1.0 : 0.0,
                                              duration: const Duration(milliseconds: 555),
                                              curve: Curves.easeIn,
                                              child: const Image(
                                                image: AssetImage("assets/gradient_border_rtl.png"),
                                                height: 59,
                                                fit: BoxFit.fill
                                              ),
                                            )
                                          ),

                                          TextField(
                                              controller: searchController,
                                              enabled: enableSearchInput,
                                              textAlign: TextAlign.left,
                                              textDirection: TextDirection.ltr,
                                              textAlignVertical: TextAlignVertical.center,
                                              maxLines: 1,
                                              cursorColor: ColorsResources.primaryColor,
                                              autofocus: false,
                                              focusNode: searchFocusNode,
                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction.search,
                                              autofillHints: candlesticksNames,
                                              autocorrect: true,
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
                                              decoration: InputDecoration(
                                                  errorText: warningNoticeSearch,
                                                  border: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                                      gapPadding: 0
                                                  ),
                                                  enabledBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                                      gapPadding: 0
                                                  ),
                                                  focusedBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                                      gapPadding: 0
                                                  ),
                                                  hintText: StringsResources.configuredCandlesticks(),
                                                  hintStyle: TextStyle(
                                                      color: ColorsResources.premiumLight,
                                                      fontSize: 23,
                                                      overflow: TextOverflow.ellipsis,
                                                      shadows: [
                                                        Shadow(
                                                            color: ColorsResources.primaryColorLighter.withOpacity(0.19),
                                                            blurRadius: 13,
                                                            offset: const Offset(-3, 3)
                                                        )
                                                      ]
                                                  )
                                              ),
                                              onChanged: (searchQuery) {

                                              },
                                              onSubmitted: (searchQuery) {

                                                searchInputActions();

                                              }
                                          )

                                        ]
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

                                        searchIconActions();

                                      },
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                                        alignment: Alignment.centerRight,
                                        child: Image(
                                          image: AssetImage(searchIcon),
                                          height: searchIconSize,
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

      ConfigurationsDataStructure configurationsDataStructure = ConfigurationsDataStructure(element);

      allCandlesticks.add(candlestickItem(configurationsDataStructure));

      candlesticksNames.add(configurationsDataStructure.candlestickNameValue());

      allCandlesticksData.add(configurationsDataStructure);

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

    return CandlesticksCard(dashboardInterfaceState: this, configurationsDataStructure: configurationsDataStructure);
  }
  /* End - Configured List */

  /*
   * Start - Search
   */
  void searchIconActions() {

    if (searchPerformed) {

      searchPerformed = false;

      setState(() {

        enableSearchInput = false;

        searchBorderOpacity = false;

        searchIcon = "assets/search_icon.png";

        searchIconSize = 43;

        searchController.text = "";

      });

    } else {

      if (searchFocusNode.hasFocus) {

        FocusScope.of(context).unfocus();

        if (searchController.text.isEmpty) {

          setState(() {

            searchBorderOpacity = false;

            searchIcon = "assets/search_icon.png";

            searchIconSize = 43;

          });

        }

        if (searchController.text.isNotEmpty) {

          processSearchQuery(searchController.text);

        }

      } else {


        setState(() {

          enableSearchInput = true;

          searchBorderOpacity = true;

        });

        Future.delayed(const Duration(milliseconds: 555), () {

          searchFocusNode.requestFocus();

        });

      }

    }

  }

  void searchInputActions() {

    if (searchController.text.isNotEmpty) {

      processSearchQuery(searchController.text);

    }

    if (searchController.text.isEmpty) {

      setState(() {

        searchBorderOpacity = false;

        searchIcon = "assets/search_icon.png";

        searchIconSize = 43;

      });

    }

  }

  void processSearchQuery(String searchQuery) {
    debugPrint("Search Query: ${searchQuery}");

    setState(() {

      searchIcon = "assets/cross_icon.png";

      searchIconSize = 31;

    });


    searchPerformed = true;

  }
  /*
   * End - Search
   */

}
