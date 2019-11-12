import 'dart:convert';
import 'dart:io';

import 'package:flow_check/conduit/actions.dart';

String path = "/appStore.json";

Map<String, dynamic> initialiseStorage(Directory directory) {
  File jsonFile = File(directory.path + path);
  jsonFile.createSync();
  jsonFile.writeAsStringSync(json.encode(appStore));
  return appStore;
}

Map<String, dynamic> saveToStore(Directory directory, String key,
    dynamic value) {
  Map<String, dynamic> jsonFileContent;
  File jsonFile = File(directory.path + path);
  jsonFileContent = json.decode(jsonFile.readAsStringSync());
  jsonFileContent[key] = value;
  jsonFile.writeAsStringSync(json.encode(jsonFileContent));
  return jsonFileContent;
}