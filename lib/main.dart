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

import 'package:age_range_signals/age_range_signals.dart';
import 'package:candlesticks/EntryConfigurations.dart';
import 'package:candlesticks/firebase_options.dart';
import 'package:candlesticks/resources/colors_resources.dart';
import 'package:candlesticks/resources/strings_resources.dart';
import 'package:candlesticks/utils/network/Networking.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast, Toast, ToastGravity;

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

  await FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode ? const AndroidDebugProvider() : const AndroidPlayIntegrityProvider(),
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final connectivityResults = await (Connectivity().checkConnectivity());

  if (connectivityResults.contains(ConnectivityResult.mobile)
      || connectivityResults.contains(ConnectivityResult.wifi)
      || connectivityResults.contains(ConnectivityResult.vpn)
      || connectivityResults.contains(ConnectivityResult.ethernet)) {

    try {

      await AgeRangeSignals.instance.initialize(
        ageGates: [18],
      );

      final ageSignalsAccess = await AgeRangeSignals.instance.requestAgeSignalsAccess();

      if (ageSignalsAccess == AgeSignalsAccessStatus.shared) {

        final ageSignalResult = await AgeRangeSignals.instance.checkAgeSignals();

        if (ageSignalResult.status == AgeSignalsStatus.verified) {

          Networking networking = Networking();

          final internetLookup = await networking.getRequest('https://8.8.8.8/');

          bool connectionResult = (int.parse(internetLookup[Networking.networkStatus].toString()) == 200);

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

        } else {

          Fluttertoast.showToast(
              msg: "Age Restriction Applied! You May Not Proceed.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.amber,
              textColor: Colors.white,
              fontSize: 16.0
          );

        }

      }

    } on SocketException catch (exception) {
      debugPrint(exception.message);


    }

  }

}