/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/22/23, 9:55 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:candlesticks/dashboard/ui/sections/SachielsSignals.dart';
import 'package:candlesticks/previews/data/previews_data_structure.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/utils/modifications/numbers.dart';
import 'package:candlesticks/utils/navigations/navigation_commands.dart';
import 'package:candlesticks/utils/ui/display.dart';
import 'package:candlesticks/utils/ui/system_bars.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_mask/widget_mask.dart';

class ConfigurationsInterface extends StatefulWidget {

  PreviewsDataStructure previewsDataStructure;

  ConfigurationsInterface({Key? key, required this.previewsDataStructure}) : super(key: key);

  @override
  State<ConfigurationsInterface> createState() => _ConfigurationsInterfaceState();
}
class _ConfigurationsInterfaceState extends State<ConfigurationsInterface> {

  Widget configurationOptions = Container();

  Widget marketsItemsPlaceholder = Container();

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

    retrieveMarkets();

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

  Widget setupConfigurationOptions() {

    return configurationOptions = Padding(
      padding: const EdgeInsets.fromLTRB(25, 357, 25, 7),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 137),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [

          setupMarkets(),

        ]
      )
    );
  }

  /*
   * Start - Markets
   */
  void retrieveMarkets() async {

    // Retrieve Markets
    // Then setState for marketsItemsPlaceholder

  }

  Widget setupMarkets() {

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

  Widget marketsItems(String marketPair) {

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
   * End - Markets
   */

}