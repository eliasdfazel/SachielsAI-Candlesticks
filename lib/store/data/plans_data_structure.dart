/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 9/2/22, 5:54 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class PlansDataStructure {

  static String purchasingPlanFile = "PurchasingPlan";

  static const String planNameStandard = "Standard";
  static const String planNameAdvanced = "Advanced";

  static const String purchasingPlanName = "purchasingPlan";
  static const String purchasingPlanDescriptionName = "purchasingPlanDescription";

  static const String purchasingPlanSnapshotName = "purchasingPlanSnapshot";
  static const String purchasingPlanPriceName = "purchasingPlanPrice";

  static const String purchasingPlanProductIdName = "purchasingPlanProductId";

  Map<String, dynamic> plansDocumentData = <String, dynamic>{};

  PlansDataStructure(DocumentSnapshot documentSnapshot) {

    plansDocumentData = documentSnapshot.data() as Map<String, dynamic>;

  }

  String purchasingPlan() {

    return plansDocumentData[PlansDataStructure.purchasingPlanName];
  }

  String purchasingPlanSnapshot() {

    return plansDocumentData[PlansDataStructure.purchasingPlanSnapshotName];
  }

  String purchasingPlanPrice() {

    return plansDocumentData[PlansDataStructure.purchasingPlanPriceName];
  }

  String purchasingPlanProductId() {

    return plansDocumentData[PlansDataStructure.purchasingPlanProductIdName];
  }

  String purchasingPlanDescription() {

    return plansDocumentData[PlansDataStructure.purchasingPlanDescriptionName];
  }

}