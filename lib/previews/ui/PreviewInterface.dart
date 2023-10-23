/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/22/23, 7:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:candlesticks/configurations/ui/ConfigurationsInterface.dart';
import 'package:candlesticks/dashboard/ui/sections/SachielsSignals.dart';
import 'package:candlesticks/previews/data/previews_data_structure.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/utils/modifications/numbers.dart';
import 'package:candlesticks/utils/navigations/navigation_commands.dart';
import 'package:candlesticks/utils/ui/display.dart';
import 'package:candlesticks/utils/ui/system_bars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:widget_mask/widget_mask.dart';

class PreviewInterface extends StatefulWidget {

  PreviewInterface({Key? key}) : super(key: key);

  @override
  State<PreviewInterface> createState() => _PreviewInterfaceState();
}
class _PreviewInterfaceState extends State<PreviewInterface> {

  Widget candlesticksPreviewsPlaceholder = Container(
    alignment: Alignment.center,
    child: LoadingAnimationWidget.staggeredDotsWave(
      colorOne: ColorsResources.premiumLight,
      colorTwo: ColorsResources.primaryColor,
      size: 73,
    ),
  );

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

    retrieveCandlesticks();

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
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
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
                      /* End - Gradient Background - Golden *//* Start - Gradient Background - Dark */
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
                                              StringsResources.candlesticks(),
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
                      candlesticksPreviewsPlaceholder,
                      /*
                       * End - List
                       */
                      /*
                       * End - Content
                       */

                      /*
                       * Start - Request
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
                                        image: AssetImage("assets/request_icon.png"),
                                      )
                                  )
                              )
                          )
                      ),
                      /*
                       * End - Request
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
                                                      StringsResources.previewTitle(),
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

  void retrieveCandlesticks() async {
    debugPrint("Retrieve Candlesticks");

    /* Start - Academy Tutorials */
    FirebaseFirestore.instance
      .collection("/Sachiels/Candlesticks/Patterns")
      .orderBy("index")
      .get().then((QuerySnapshot querySnapshot) {

        List<PreviewsDataStructure> previewsDataStructure = [];

        for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {

          previewsDataStructure.add(PreviewsDataStructure(queryDocumentSnapshot));

        }

        if (previewsDataStructure.isNotEmpty) {

          prepareCandlesticks(previewsDataStructure);

        }

      },
      onError: (e) => {

      });

  }

  void prepareCandlesticks(List<PreviewsDataStructure> previewsDataStructure) async {

    List<Widget> allCandlesticksPreviews = [];

    for (var previewCandlestick in previewsDataStructure) {

      allCandlesticksPreviews.add(previewItem(previewCandlestick));

    }

    int gridColumnCount = (displayLogicalWidth(context) / 199).round();

    setState(() {

      candlesticksPreviewsPlaceholder = Padding(
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
              children: allCandlesticksPreviews
          )
      );

    });

  }

  Widget previewItem(PreviewsDataStructure previewsDataStructure) {
    debugPrint("Candlestick; ${previewsDataStructure.candlestickNameValue()}");

    return ClipRRect(
      borderRadius: BorderRadius.circular(19),
      child: Material(
          shadowColor: Colors.transparent,
          color: Colors.transparent,
          child: InkWell(
            splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
            splashFactory: InkRipple.splashFactory,
            onTap: () {

              navigateTo(context, ConfigurationsInterface(previewsDataStructure: previewsDataStructure));

            },
            child: Container(
                color: ColorsResources.premiumDark.withOpacity(0.37),
                child: Stack(
                    children: [

                      Center(
                          child: Image(
                            image: NetworkImage(previewsDataStructure.candlestickImageValue()),
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
                                                  previewsDataStructure.candlestickNameValue(),
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
                                                  previewsDataStructure.candlestickDirectionValue(),
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

}