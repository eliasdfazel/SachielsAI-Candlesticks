/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 8/30/22, 7:59 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class PreviewsDataStructure {

  static const String index = "index";

  static const String candlestickName = "candlestickName";
  static const String candlestickDescription = "candlestickDescription";
  static const String candlestickImage = "candlestickImage";

  static const String candlestickDirection = "candlestickDirection";

  Map<String, dynamic> previewsDocumentData = <String, dynamic>{};

  PreviewsDataStructure(DocumentSnapshot previewsDocument) {

    previewsDocumentData = previewsDocument.data() as Map<String, dynamic>;

  }

  String indexValue() {

    return previewsDocumentData[PreviewsDataStructure.index].toString();
  }

  String candlestickNameValue() {

    return previewsDocumentData[PreviewsDataStructure.candlestickName].toString();
  }

  String candlestickDescriptionValue() {

    return previewsDocumentData[PreviewsDataStructure.candlestickDescription].toString();
  }

  String candlestickImageValue() {

    return previewsDocumentData[PreviewsDataStructure.candlestickImage].toString();
  }

  String candlestickDirectionValue() {

    return previewsDocumentData[PreviewsDataStructure.candlestickDirection].toString();
  }

}