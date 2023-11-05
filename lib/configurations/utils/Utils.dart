/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/31/23, 10:10 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

String configurationsDocumentPath(String emailAddress, String candlestickName) {

  String firestorePath = "Sachiels/Candlesticks/Profiles/${emailAddress.toUpperCase()}/Configurations/$candlestickName";

  return firestorePath;
}

String configurationsCollectionPath(String emailAddress) {

  String firestorePath = "Sachiels/Candlesticks/Profiles/${emailAddress.toUpperCase()}/Configurations";

  return firestorePath;
}

String candlestickPreviewDocumentPath(candlestickName) {

  return "/Sachiels/Candlesticks/Patterns/$candlestickName";
}

Map<String, dynamic> candlestickDocument(String candlestickName, String candlestickImage, String candlestickMarketDirection, String configuredMarkets, String configuredTimeframes) {

  return {
    "candlestickName": candlestickName,
    "candlestickImage": candlestickImage,
    "candlestickMarketDirection": candlestickMarketDirection,
    "configuredMarkets": configuredMarkets,
    "configuredTimeframes": configuredTimeframes,
    "notificationStatus": true,
  };
}

/// [a-z A-Z 0-9 -_.~%] {1,900} <br/>
/// For Example; DOJIGreenDailyEURUSD, DOJIRed4HoursEURUSD
String notificationTopic(String candlestickName, String timeframe, String market) {

  String notificationTopic = "${candlestickName.replaceAll(" ", "")}${timeframe.replaceAll(" ", "")}${market.replaceAll(" ", "")}";

  return notificationTopic;
}