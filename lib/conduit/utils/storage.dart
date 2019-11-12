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
