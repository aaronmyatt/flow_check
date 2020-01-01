import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Map<String, dynamic> storageModel = {"flowList": []};
String path = "/appStore.json";

class LocalStorageService {
  static Future<String> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File jsonFile = File(directory.path + path);
    bool exists = await jsonFile.exists();
    if (exists) {
      return await jsonFile.readAsString();
    } else {
      jsonFile.createSync();
      String store = json.encode(storageModel);
      jsonFile.writeAsString(store);
      return store;
    }
  }

  static void save(String payload) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File jsonFile = File(directory.path + path);
    jsonFile.writeAsStringSync(payload);
  }
}
