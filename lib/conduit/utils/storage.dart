import 'dart:convert';
import 'dart:io';

Map<String, dynamic> appStore = {
  "currentCoordinates": {
    "tapX": 0.0,
    "tapY": 0.0,
  },
  "currentName": "",
  "currentFlow": "",
  "flowList": [],
  "activeFlow": {
    "timestamp": "",
    "name": "",
    "flowType": "",
    "coordinates": {
      "tapX": 0.0,
      "tapY": 0.0,
    }
  }
};

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
  jsonFileContent = fetchFromStore(directory);
  jsonFileContent[key] = value;
  jsonFile.writeAsStringSync(json.encode(jsonFileContent));
  return jsonFileContent;
}

Map<String, dynamic> fetchFromStore(Directory directory,) {
  File jsonFile = File(directory.path + path);
  return json.decode(jsonFile.readAsStringSync());
}