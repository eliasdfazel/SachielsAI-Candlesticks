/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/31/23, 10:10 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

/// [a-z A-Z 0-9 -_.~%] {1,900}
String notificationTopic(String candlestickName, String timeframe, String market) {

  String notificationTopic = "${candlestickName.replaceAll(" ", "")}${timeframe.replaceAll(" ", "")}${market.replaceAll(" ", "")}";

  return notificationTopic;
}