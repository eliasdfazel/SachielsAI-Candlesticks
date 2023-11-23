/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/4/23, 11:09 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:candlesticks/browser/ui/browser.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/store/data/plans_data_structure.dart';
import 'package:candlesticks/store/ui/DigitalStore.dart';
import 'package:candlesticks/utils/navigations/navigation_commands.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Menus extends StatefulWidget {

  const Menus({Key? key}) : super (key: key);

  @override
  State<Menus> createState() => _MenusState();
}
class _MenusState extends State<Menus> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
        padding: const EdgeInsets.fromLTRB(19, 37, 0, 37),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [

          SizedBox(
              height: 73,
              child: InkWell(
                  onTap: () {

                    launchUrlString(StringsResources.geeksEmpireAndroid(), mode: LaunchMode.externalApplication);

                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const Image(
                            image: AssetImage("assets/geeksempire.png")
                        ),

                        const SizedBox(
                          width: 19,
                        ),

                        Expanded(
                            child: Text(
                              StringsResources.geeksEmpire(),
                              maxLines: 2,
                              style: const TextStyle(
                                  color: ColorsResources.light,
                                  fontSize: 23
                              ),
                            )
                        )

                      ]
                  )
              )
          ),

          const Divider(
            height: 73,
            color: Colors.transparent,
          ),

          SizedBox(
              height: 51,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {

                            navigateTo(context, DigitalStore(planName: PlansDataStructure.planNameStandard));

                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Image(
                                      image: AssetImage("assets/store_icon.png"),
                                      color: ColorsResources.light,
                                    )
                                ),

                                const SizedBox(
                                  width: 19,
                                ),

                                Expanded(
                                    child: Text(
                                      StringsResources.store(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: ColorsResources.lightTransparent,
                                          fontSize: 19
                                      ),
                                    )
                                )

                              ]
                          )
                      )
                  )
              )
          ),

          const Divider(
            height: 13,
            color: Colors.transparent,
          ),

          SizedBox(
              height: 51,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {

                            if (FirebaseAuth.instance.currentUser != null) {

                              navigateTo(context, Browser(websiteAddress: "${StringsResources.historyLink()}?authenticationId=${FirebaseAuth.instance.currentUser!.email!.toUpperCase()}"));

                            }

                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Image(
                                      image: AssetImage("assets/history_icon.png"),
                                      color: ColorsResources.light,
                                    )
                                ),

                                const SizedBox(
                                  width: 19,
                                ),

                                Expanded(
                                    child: Text(
                                      StringsResources.history(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: ColorsResources.lightTransparent,
                                          fontSize: 19
                                      ),
                                    )
                                )

                              ]
                          )
                      )
                  )
              )
          ),

          const Divider(
            height: 13,
            color: Colors.transparent,
          ),

          SizedBox(
              height: 51,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {

                            navigateTo(context, Browser(websiteAddress: StringsResources.academyLink()));

                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Image(
                                      image: AssetImage("assets/newspaper.png"),
                                      color: ColorsResources.light,
                                    )
                                ),

                                const SizedBox(
                                  width: 19,
                                ),

                                Expanded(
                                    child: Text(
                                      StringsResources.academy(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: ColorsResources.lightTransparent,
                                          fontSize: 19
                                      ),
                                    )
                                )

                              ]
                          )
                      )
                  )
              )
          ),

          const Divider(
            height: 17,
            color: ColorsResources.premiumDarkTransparent,
          ),

          SizedBox(
              height: 51,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {

                            launchUrlString(StringsResources.tosLink(), mode: LaunchMode.externalApplication);

                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                const Padding(
                                    padding: EdgeInsets.all(11),
                                    child: Image(
                                      image: AssetImage("assets/tos.png"),
                                      color: ColorsResources.light,
                                    )
                                ),

                                const SizedBox(
                                  width: 19,
                                ),

                                Expanded(
                                    child: Text(
                                      StringsResources.tos(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: ColorsResources.lightTransparent,
                                          fontSize: 15
                                      ),
                                    )
                                )

                              ]
                          )
                      )
                  )
              )
          ),

          const Divider(
            height: 7,
            color: Colors.transparent,
          ),

          SizedBox(
              height: 51,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {

                            launchUrlString(StringsResources.privacyPolicyLink(), mode: LaunchMode.externalApplication);

                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                const Padding(
                                    padding: EdgeInsets.all(11),
                                    child: Image(
                                      image: AssetImage("assets/privacy.png"),
                                      color: ColorsResources.light,
                                    )
                                ),

                                const SizedBox(
                                  width: 19,
                                ),

                                Expanded(
                                    child: Text(
                                      StringsResources.privacyPolicy(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: ColorsResources.lightTransparent,
                                          fontSize: 15
                                      ),
                                    )
                                )

                              ]
                          )
                      )
                  )
              )
          ),

          const Divider(
            height: 73,
            color: Colors.transparent,
          ),

          SizedBox(
              height: 51,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    InkWell(
                        onTap: () {

                          launchUrlString(StringsResources.threadsLink(), mode: LaunchMode.externalApplication);

                        },
                        child: const Image(
                          image: AssetImage("assets/threads_icon.png"),
                          height: 51,
                          width: 51,
                        )
                    ),

                    Container(
                      width: 13,
                    ),

                    InkWell(
                        onTap: () {

                          launchUrlString(StringsResources.xLink(), mode: LaunchMode.externalApplication);

                        },
                        child: const Image(
                          image: AssetImage("assets/twitter_icon.png"),
                          height: 51,
                          width: 51,
                        )
                    )

                  ]
              )
          ),

        ]
    );
  }

}
