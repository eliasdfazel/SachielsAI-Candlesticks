
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryDataStructure {

  static const String timestamp = "timestamp";

  static const String candlestickName = "candlestickName";
  static const String candlestickImage = "candlestickImage";

  static const String marketDirection = "marketDirection";
  static const String marketPair = "marketPair";

  static const String timeframe = "timeframe";

  Map<String, dynamic> documentData = <String, dynamic>{};

  HistoryDataStructure(DocumentSnapshot docuemtnSnapshot) {

    documentData = docuemtnSnapshot.data() as Map<String, dynamic>;

  }

  String timestampValue() {

    return documentData[HistoryDataStructure.timestamp].toString();
  }

  String candlestickNameValue() {

    return documentData[HistoryDataStructure.candlestickName].toString();
  }

  String candlestickImageValue() {

    return documentData[HistoryDataStructure.candlestickImage].toString();
  }

  String marketDirectionValue() {

    return documentData[HistoryDataStructure.marketDirection].toString();
  }

  String marketPairValue() {

    return documentData[HistoryDataStructure.marketPair].toString();
  }

  String timeframeValue() {

    return documentData[HistoryDataStructure.timeframe].toString();
  }

}