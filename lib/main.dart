/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 10/17/23, 7:00 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:candlesticks/EntryConfigurations.dart';
import 'package:candlesticks/firebase_options.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
  debugPrint("Sachiels Signal Received: ${remoteMessage.data}");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

}

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  var firebaseInitialized = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var appCheckProvider = AndroidProvider.playIntegrity;

  if (kDebugMode) {
    appCheckProvider = AndroidProvider.debug;
  }

  await FirebaseAppCheck.instance.activate(
    androidProvider: appCheckProvider,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile
      || connectivityResult == ConnectivityResult.wifi
      || connectivityResult == ConnectivityResult.vpn
      || connectivityResult == ConnectivityResult.ethernet) {

    try {

      final internetLookup = await InternetAddress.lookup('sachiel-s-signals.web.app');

      bool connectionResult = (internetLookup.isNotEmpty && internetLookup[0].rawAddress.isNotEmpty);

      await FirebaseAuth.instance.currentUser?.reload();

      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

      firebaseMessaging.subscribeToTopic("StatusAI");

      runApp(
          Phoenix(
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: StringsResources.applicationName(),
                  color: ColorsResources.primaryColor,
                  theme: ThemeData(
                    fontFamily: 'Ubuntu',
                    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
                    pageTransitionsTheme: const PageTransitionsTheme(builders: {
                      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                    }),
                  ),
                  home: EntryConfigurations(internetConnection: connectionResult)
              )
          )
      );

    } on SocketException catch (exception) {
      debugPrint(exception.message);


    }

  }

}