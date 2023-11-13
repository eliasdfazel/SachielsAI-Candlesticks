/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/21/22, 1:35 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';

import 'package:candlesticks/store/data/plans_data_structure.dart';
import 'package:candlesticks/utils/io/file_io.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class DigitalStoreUtils {

  Future validateSubscriptions() async {

    bool alreadyPurchased = await fileExist(PlansDataStructure.purchasingPlanFile, "TXT");

    if (alreadyPurchased) {

      InAppPurchase.instance.purchaseStream.listen((purchaseDetailsList) {

        for (var purchaseDetails in purchaseDetailsList) {

          if (purchaseDetails.status == PurchaseStatus.pending) {


          } else {

            if (purchaseDetails.status == PurchaseStatus.error
                || purchaseDetails.status == PurchaseStatus.canceled) {

              deletePrivateFile(PlansDataStructure.purchasingPlanFile, "TXT");

            } else if (purchaseDetails.status == PurchaseStatus.purchased
                || purchaseDetails.status == PurchaseStatus.restored) {

              createFileOfTexts(PlansDataStructure.purchasingPlanFile, "TXT", purchaseDetails.productID);

            }

            if (purchaseDetails.pendingCompletePurchase) {



            }

          }

        }

      }, onDone: () {

      }, onError: (error) {

      });

      await InAppPurchase.instance.restorePurchases();

    }

  }

}