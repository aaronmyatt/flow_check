import 'dart:convert';
import 'dart:developer';
import 'dart:io';

enum Actions {
  SETUP_STORAGE,
  FLOW_COORDINATES,
  NAME_INPUT,
  STORE_FLOW,
  STORE_REPORT,
  LIST_FLOWS,
  ACTIVATE_FLOW,
  ACTIVE_FLOW,
}

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

dynamic performAction(Actions actionName,
    {Map<String, dynamic> params: const {}}) {
  log(actionName.toString(), name: 'Conduit Action Name');
  log(params.toString(), name: 'Conduit Params');

  Directory directory = params['directory'] ?? getDirectory();
  File jsonFile = File(directory.path + path);

  switch (actionName) {
    case Actions.SETUP_STORAGE:
      {
        jsonFile.createSync();
        jsonFile.writeAsStringSync(json.encode(appStore));
      }
      break;
    case Actions.FLOW_COORDINATES:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        jsonFileContent.addAll({
          "currentCoordinates": {'tapX': params['tapX'], 'tapY': params['tapY']}
        });
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      }
      break;
    case Actions.NAME_INPUT:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        jsonFileContent.addAll({'currentName': params['currentName']});
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      }
      break;
    case Actions.STORE_FLOW:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        jsonFileContent.addAll({"currentFlow": params['flow']});
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      }
      break;
    case Actions.STORE_REPORT:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        Map flow = {
          "name": jsonFileContent["currentName"],
          "flowType": jsonFileContent["currentFlow"],
          "coordinates": jsonFileContent["currentCoordinates"],
          "timestamp": DateTime
              .now()
              .millisecondsSinceEpoch,
        };
        jsonFileContent["flowList"].add(flow);
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
        return flow;
      }
      break;
    case Actions.LIST_FLOWS:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        return jsonFileContent["flowList"];
      }
      break;
    case Actions.ACTIVATE_FLOW:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        jsonFileContent["activeFlow"] = params["flow"];
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      }
      break;
    case Actions.ACTIVE_FLOW:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        return jsonFileContent["activeFlow"];
      }
      break;
    default:
      {
        log('NO MATCH', name: 'DEFAULT ACTION');
      }
  }
}

Directory getDirectory() {
  Directory directory = Directory('./.conduit');
  directory.createSync();
  return directory;
}

