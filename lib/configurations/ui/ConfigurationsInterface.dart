/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/22/23, 9:55 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/utils/ui/system_bars.dart';
import 'package:flutter/material.dart';

class ConfigurationsInterface extends StatefulWidget {

  const ConfigurationsInterface({Key? key}) : super(key: key);

  @override
  State<ConfigurationsInterface> createState() => _ConfigurationsInterfaceState();
}

class _ConfigurationsInterfaceState extends State<ConfigurationsInterface> {

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.black, ColorsResources.black);

  }

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}