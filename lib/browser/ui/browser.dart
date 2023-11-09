/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/16/22, 8:50 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/utils/modifications/numbers.dart';
import 'package:candlesticks/utils/navigations/navigation_commands.dart';
import 'package:candlesticks/utils/ui/display.dart';
import 'package:candlesticks/utils/ui/system_bars.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {

  String websiteAddress;

  Browser({Key? key, required this.websiteAddress}) : super(key: key);

  @override
  State<Browser> createState() => _BrowserState();

}
class _BrowserState extends State<Browser> {

  bool loadingAnimationVisibility = true;

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePop(context);

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

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
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
            backgroundColor: ColorsResources.black,
            body: Stack(
              children: [

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

                /* Start - Browser */
                ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: WebView(
                      initialUrl: widget.websiteAddress,
                      javascriptMode: JavascriptMode.unrestricted,
                      backgroundColor: ColorsResources.dark,
                      onPageFinished: (_) {

                        setState(() {

                          loadingAnimationVisibility = false;

                        });

                      },
                      onWebViewCreated: (_) {
                        debugPrint("Website Loaded Completely.");

                      },
                    )
                ),
                /* End - Browser */

                Align(
                  alignment: Alignment.center,
                  child: Visibility(
                      visible: loadingAnimationVisibility,
                      child: Container(
                        height: 399,
                        width: 351,
                        alignment: Alignment.center,
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          colorOne: ColorsResources.premiumLight,
                          colorTwo: ColorsResources.primaryColor,
                          size: 73,
                        )
                      )
                  )
                ),

              ],
            )
        )
    );
  }

}
