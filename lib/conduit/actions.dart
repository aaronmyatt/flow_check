import 'dart:io';

import './utils/storage.dart';

String path = "/appStore.json";
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

Directory directory(dir) {
  return dir ?? getDirectory();
}

Directory getDirectory() {
  Directory directory = Directory('./.conduit');
  directory.createSync();
  return directory;
}

void setupStorage({Directory dir: null}) {
  initialiseStorage(directory(dir));
}

Map<String, dynamic> flowCoordinates(double tapX, double tapY,
    {Directory dir: null}) {
  return saveToStore(
      directory(dir), 'currentCoordinates', {'tapX': tapX, 'tapY': tapY});
}

Map<String, dynamic> nameInput(String name, {Directory dir: null}) {
  return saveToStore(directory(dir), 'currentName', name);
}

Map<String, dynamic> storeFlow(String flow, {Directory dir: null}) {
  return saveToStore(directory(dir), 'currentFlow', flow);
}

Map<String, dynamic> storeReport({Directory dir: null}) {
  Map<String, dynamic> jsonFileContent = fetchFromStore(directory(dir));
  Map<String, dynamic> flow = {
    "name": jsonFileContent["currentName"],
    "flowType": jsonFileContent["currentFlow"],
    "coordinates": jsonFileContent["currentCoordinates"],
    "timestamp": DateTime
        .now()
        .millisecondsSinceEpoch,
  };
  List flowList = jsonFileContent["flowList"];
  flowList.add(flow);

  return saveToStore(directory(dir), 'flowList', flowList);
}

List listFlows({Directory dir: null}) {
  Map<String, dynamic> jsonFileContent = fetchFromStore(directory(dir));
  return jsonFileContent["flowList"];
}

Map<String, dynamic> activateFlow(Map<String, dynamic> flow,
    {Directory dir: null}) {
  return saveToStore(directory(dir), 'activeFlow', flow);
}

Map<String, dynamic> getStore({Directory dir: null}) {
  return fetchFromStore(directory(dir));
}

String flowTypeIconPath(String flowType) {
  Map<String, String> paths = {
    'nostalgia': 'assets/nostalgia.svg',
    'anxiety': 'assets/anxiety.svg',
    'apathy': 'assets/apathy.svg',
    'doubt': 'assets/doubt.svg',
    'flow': 'assets/flow.svg',
    'boredom': 'assets/boredom.svg',
  };
  return paths[flowType];
}

void main() {
  setupStorage();
  print(flowCoordinates(1, 2));
//  print(
//      performAction(Actions.NAME_INPUT, params: {'currentName': 'Aaron'}));
//  print(
//      performAction(Actions.STORE_FLOW, params: {'flow': 'flow'}));
//  print(
//      performAction(Actions.STORE_REPORT));
//  var store = fetchToStore(getDirectory());
//  performAction(Actions.ACTIVATE_FLOW, params: {'flow': store['flowList'][0]});
//  performAction(Actions.ACTIVE_FLOW);
}
