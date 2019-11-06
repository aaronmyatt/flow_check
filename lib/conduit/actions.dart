import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../flow_areas.dart';

enum Actions {
  SETUP_STORAGE,
  FLOW_COORDINATES,
  NAME_INPUT,
  DETERMINE_FLOW,
  STORE_FLOW,
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
    {Map<String, dynamic> params: const {}}) async {
  log(actionName.toString(), name: 'Conduit Action Name');
  log(params.toString(), name: 'Conduit Params');

  switch (actionName) {
    case Actions.SETUP_STORAGE:
      {
        Directory directory = await getDirectory();
        File file = new File(directory.path + "/appStore.json");
        file.createSync();
        file.writeAsStringSync(json.encode(appStore));
      }
      break;
    case Actions.FLOW_COORDINATES:
      {
        Directory directory = await getDirectory();
        File jsonFile = new File(directory.path + path);
        Map<String, dynamic> jsonFileContent =
            json.decode(jsonFile.readAsStringSync());
        jsonFileContent.addAll({"currentCoordinates": params});
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      }
      break;
    case Actions.NAME_INPUT:
      {
        Directory directory = await getDirectory();
        File jsonFile = new File(directory.path + path);
        Map<String, dynamic> jsonFileContent =
            json.decode(jsonFile.readAsStringSync());
        jsonFileContent.addAll(params);
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      }
      break;
    case Actions.DETERMINE_FLOW:
      {
        Directory directory = await getDirectory();
        File jsonFile = new File(directory.path + path);
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        double x = jsonFileContent["currentCoordinates"]["tapX"];
        double y = jsonFileContent["currentCoordinates"]["tapY"];
        String flow =
            FlowAreas(params["width"], params["height"]).flowCheck(x, y);
        jsonFileContent.addAll({"currentFlow": flow});
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      }
      break;
    case Actions.STORE_FLOW:
      {
        Directory directory = await getDirectory();
        File jsonFile = new File(directory.path + path);
        Map<String, dynamic> jsonFileContent =
            json.decode(jsonFile.readAsStringSync());
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
        log(jsonFileContent.toString(), name: actionName.toString());
      }
      break;
    case Actions.LIST_FLOWS:
      {
        Directory directory = await getDirectory();
        File jsonFile = new File(directory.path + path);
        Map<String, dynamic> jsonFileContent =
            json.decode(jsonFile.readAsStringSync());
        return jsonFileContent["flowList"];
      }
      break;
    case Actions.ACTIVATE_FLOW:
      {
        Directory directory = await getDirectory();
        File jsonFile = new File(directory.path + path);
        Map<String, dynamic> jsonFileContent =
            json.decode(jsonFile.readAsStringSync());
        jsonFileContent["activeFlow"] = params["flow"];
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      }
      break;
    case Actions.ACTIVE_FLOW:
      {
        Directory directory = await getDirectory();
        File jsonFile = new File(directory.path + path);
        Map<String, dynamic> jsonFileContent =
            json.decode(jsonFile.readAsStringSync());
        return jsonFileContent["activeFlow"];
      }
      break;
    default:
      {
        log('NO MATCH', name: 'DEFAULT ACTION');
      }
  }
}

Future<Directory> getDirectory() async {
  Directory directory = await getApplicationDocumentsDirectory();
  return directory;
}

main() {
  performAction(Actions.SETUP_STORAGE);
  performAction(Actions.LIST_FLOWS);
}
