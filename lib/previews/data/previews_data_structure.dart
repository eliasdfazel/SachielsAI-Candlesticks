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

class PreviewaDataStructure {

  static const String index = "index";

  static const String candlestickName = "candlestickName";
  static const String candlestickDescription = "candlestickDescription";
  static const String candlestickImage = "candlestickImage";

  static const String candlestickDirection = "candlestickDirection";

  Map<String, dynamic> previewsDocumentData = <String, dynamic>{};

  PreviewaDataStructure(DocumentSnapshot previewsDocument, String postType) {

    previewsDocumentData = previewsDocument.data() as Map<String, dynamic>;

  }

  String indexValue() {

    return previewsDocumentData[PreviewaDataStructure.index].toString();
  }

  String candlestickNameValue() {

    return previewsDocumentData[PreviewaDataStructure.candlestickName].toString();
  }

  String candlestickDescriptionValue() {

    return previewsDocumentData[PreviewaDataStructure.candlestickDescription].toString();
  }

  String candlestickImageValue() {

    return previewsDocumentData[PreviewaDataStructure.candlestickImage].toString();
  }

  String candlestickDirectionValue() {

    return previewsDocumentData[PreviewaDataStructure.candlestickDirection].toString();
  }

}