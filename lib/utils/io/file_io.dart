/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 9/10/22, 7:58 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<bool> fileExist(String fileName, String fileFormat) async {

  Directory appDocumentsDirectory = await getApplicationSupportDirectory();

  String appDocumentsPath = appDocumentsDirectory.path;

  String filePath = '$appDocumentsPath/$fileName.$fileFormat';

  File file = File(filePath);

  return file.exists();
}

Future<File> createFileOfBytes(String fileName, String fileFormat, Uint8List contentBytes) async {

  Directory appDocumentsDirectory = await getApplicationSupportDirectory();

  String appDocumentsPath = appDocumentsDirectory.path;

  String filePath = '$appDocumentsPath/$fileName.$fileFormat';

  return File(filePath).writeAsBytes(contentBytes);
}

Future<File> createFileOfTexts(String fileName, String fileFormat, String contentBytes) async {

  Directory appDocumentsDirectory = await getApplicationSupportDirectory();

  String appDocumentsPath = appDocumentsDirectory.path;

  String filePath = '$appDocumentsPath/${fileName}.${fileFormat}';

  return File(filePath).writeAsString(contentBytes);
}

Future<String> readFileOfTexts(String fileName, String fileFormat) async {

  Directory appDocumentsDirectory = await getApplicationSupportDirectory();

  String appDocumentsPath = appDocumentsDirectory.path;

  String filePath = '$appDocumentsPath/$fileName.$fileFormat';

  return File(filePath).readAsString();
}

void deletePrivateFile(String fileName, String fileFormat) async {

  Directory appDocumentsDirectory = await getApplicationSupportDirectory();

  String appDocumentsPath = appDocumentsDirectory.path;

  String filePath = '$appDocumentsPath/$fileName.$fileFormat';

  File(filePath).delete();

}