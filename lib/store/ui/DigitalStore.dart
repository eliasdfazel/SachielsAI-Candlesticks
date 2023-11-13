/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/13/23, 4:32 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/store/data/plans_data_structure.dart';
import 'package:candlesticks/utils/io/file_io.dart';
import 'package:candlesticks/utils/modifications/numbers.dart';
import 'package:candlesticks/utils/navigations/navigation_commands.dart';
import 'package:candlesticks/utils/ui/display.dart';
import 'package:candlesticks/utils/ui/system_bars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:widget_mask/widget_mask.dart';

class DigitalStore extends StatefulWidget {

  String planName;

  DigitalStore({Key? key, required this.planName});

  @override
  State<DigitalStore> createState() => _DigitalStoreState();

}
class _DigitalStoreState extends State<DigitalStore> with TickerProviderStateMixin {

  Widget planDetailsPlaceholder = Container();

  StreamSubscription<List<PurchaseDetails>>? streamSubscription;

  bool animationVisibility = false;

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePop(context);

    return true;
  }

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    streamSubscription?.cancel();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

    BackButtonInterceptor.add(aInterceptor);

    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;

    streamSubscription = purchaseUpdated.listen((purchaseDetailsList) {

      purchaseUpdatedListener(purchaseDetailsList);

    }, onDone: () {

      streamSubscription?.cancel();

    }, onError: (error) {

    }) as StreamSubscription<List<PurchaseDetails>>?;

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

                      planDetailsPlaceholder,

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

                                          navigatePopWithResult(context, true);

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
                                                      StringsResources.store(),
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

                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Visibility(
                              visible: animationVisibility,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 153),
                                  child: LoadingAnimationWidget.staggeredDotsWave(
                                    colorOne: ColorsResources.premiumLight,
                                    colorTwo: ColorsResources.primaryColor,
                                    size: 53,
                                  )
                              )
                          )
                      )

                    ]
                )
            )
        )
    );
  }

  // Collection;
  void retrievePlan() async {
    debugPrint("Retrieve Plan; ${widget.planName}");

    FirebaseFirestore.instance
        .doc("/Sachiels/Candlesticks/Plans/${widget.planName}")
        .get().then((DocumentSnapshot documentSnapshot) {

          PlansDataStructure plansDataStructure = PlansDataStructure(documentSnapshot);

          preparePlan(plansDataStructure);

        });

  }

  void preparePlan(PlansDataStructure plansDataStructure) {

    setState(() {

      planDetailsPlaceholder = planDetails(plansDataStructure);

    });

  }

  Widget planDetails(PlansDataStructure plansDataStructure) {
    debugPrint("Plan Details: ${plansDataStructure.plansDocumentData}");

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 91, 37, 19),
        child: SizedBox(
            height: double.maxFinite,
            width: 353,
            child: InkWell(
                onTap: () async {

                  setState(() {

                    animationVisibility = true;

                  });

                  final ProductDetailsResponse productDetailsResponse  = await InAppPurchase.instance.queryProductDetails({plansDataStructure.purchasingPlanProductId()});

                  PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetailsResponse.productDetails.first);

                  await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Image.network(
                          plansDataStructure.purchasingPlanSnapshot(),
                          height: 353,
                          width: 353,
                          fit: BoxFit.contain,
                        )
                    ),

                    Padding(
                        padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                        child: Html(
                            data: plansDataStructure.purchasingPlanDescription()
                        )
                    ),

                    const Image(
                      image: AssetImage("assets/purchasing_icon.png"),
                      height: 73,
                      width: 353,
                      fit: BoxFit.contain,
                    )

                  ],
                )
            )
        )
    );
  }

  void purchaseUpdatedListener(List<PurchaseDetails> purchaseDetailsList) async {

    for (var purchaseDetails in purchaseDetailsList) {

      if (purchaseDetails.status == PurchaseStatus.pending) {


      } else {

        if (purchaseDetails.status == PurchaseStatus.error) {



        } else if (purchaseDetails.status == PurchaseStatus.purchased
            || purchaseDetails.status == PurchaseStatus.restored) {

          setState(() {

            animationVisibility = false;

          });

        }

        if (purchaseDetails.pendingCompletePurchase) {

          await InAppPurchase.instance.completePurchase(purchaseDetails);

          createFileOfTexts(PlansDataStructure.purchasingPlanFile, "TXT", purchaseDetails.productID);

        }

      }

    }

  }

}