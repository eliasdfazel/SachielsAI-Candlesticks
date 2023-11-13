/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/13/23, 4:32 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:candlesticks/dashboard/ui/sections/menus.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/utils/modifications/numbers.dart';
import 'package:candlesticks/utils/ui/display.dart';
import 'package:candlesticks/utils/ui/system_bars.dart';
import 'package:flutter/material.dart';

class DigitalStore extends StatefulWidget {

  DigitalStore({Key? key});

  @override
  State<DigitalStore> createState() => _DigitalStoreState();

}
class _DigitalStoreState extends State<DigitalStore> with TickerProviderStateMixin {

  /*
   * Start - Menu
   */
  late AnimationController animationController;

  late Animation<Offset> offsetAnimation;
  late Animation<double> doubleAnimation;

  late Animation<Offset> offsetAnimationItems;
  double opacityAnimation = 0.37;

  bool menuOpen = false;
  /*
   * End - Menu
   */

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

    animationController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 777),
        reverseDuration: const Duration(milliseconds: 333),
        animationBehavior: AnimationBehavior.preserve);

    offsetAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.49, 0))
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn
    ));
    doubleAnimation = Tween<double>(begin: 1, end: 0.91)
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut
    ));

    offsetAnimationItems = Tween<Offset>(begin: const Offset(-0.13, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn
    ));

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
                  TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder()
                })
            ),
            home: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorsResources.black,
                body: Stack(
                    children: [

                      Container(
                          width: calculatePercentage(53, displayLogicalWidth(context)),
                          alignment: AlignmentDirectional.centerStart,
                          color: Colors.black,
                          child: AnimatedOpacity(
                              opacity: opacityAnimation,
                              duration: Duration(milliseconds: menuOpen ? 753 : 137),
                              child: SlideTransition(
                                  position: offsetAnimationItems,
                                  child: const Menus()
                              )
                          )
                      ),

                      allContent()

                    ]
                )
            )
        )
    );
  }

  Widget allContent() {

    return SlideTransition(
        position: offsetAnimation,
        child: ScaleTransition(
            scale: doubleAnimation,
            child: Stack(
                children: [

                  Stack(
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
                        /* End - Decorations */



                      ]
                  )

                ]
            )
        )
    );
  }

}