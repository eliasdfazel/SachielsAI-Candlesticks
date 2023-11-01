/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/31/23, 9:33 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class ConfigurationsDataStructure {

  static const String configuredMarkets = "configuredMarkets";
  static const String configuredTimeframes = "configuredTimeframes";

  static const String candlestickName = "candlestickName";
  static const String candlestickImage = "candlestickImage";
  static const String candlestickMarketDirection = "candlestickMarketDirection";

  Map<String, dynamic> documentData = <String, dynamic>{};

  ConfigurationsDataStructure(DocumentSnapshot documentSnapshot) {

    documentData = documentSnapshot.data() as Map<String, dynamic>;

  }

  String configuredMarketsValue() {

    return documentData[ConfigurationsDataStructure.configuredMarkets].toString();
  }

  String configuredTimeframesValue() {

    return documentData[ConfigurationsDataStructure.configuredTimeframes].toString();
  }

  String candlestickNameValue() {

    return documentData[ConfigurationsDataStructure.candlestickName].toString();
  }

  String candlestickImageValue() {

    return documentData[ConfigurationsDataStructure.candlestickImage].toString();
  }

  String candlestickMarketDirectionValue() {

    return documentData[ConfigurationsDataStructure.candlestickMarketDirection].toString();
  }

}