/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/19/23, 10:20 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SachielsSignals extends StatefulWidget {

  const SachielsSignals({Key? key}) : super(key: key);

  @override
  State<SachielsSignals> createState() => _SachielsSignalsStates();

}
class _SachielsSignalsStates extends State<SachielsSignals> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 59,
      width: 59,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: ColorsResources.primaryColorLighter,
                blurRadius: 51,
                spreadRadius: 0,
                offset: Offset(0, 0)
            )
          ]
      ),
      child: SizedBox(
          height: 59,
          width: 59,
          child: InkWell(
              onTap: () {

                launchUrlString(StringsResources.sachielsSignalsLink(), mode: LaunchMode.externalApplication);

              },
              child: const Image(
                image: AssetImage("assets/sachiels_signals_logo.png"),
              )
          )
      ),
    );
  }

}