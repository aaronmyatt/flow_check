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

Map<String, dynamic> performAction(Actions actionName,
    {Map<String, dynamic> params: const {}}) {
  logit(actionName, params);

  Map<String, dynamic> output = {
    'data': {},
    'status': 'success'
  };
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
          'currentCoordinates': {'tapX': params['tapX'], 'tapY': params['tapY']}
        });
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
        output.update('data', (value) {
          return jsonFileContent['currentCoordinates'];
        });
      }
      break;
    case Actions.NAME_INPUT:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        jsonFileContent.addAll({'currentName': params['currentName']});
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
        output.update('data', (value) {
          return jsonFileContent['currentName'];
        });
      }
      break;
    case Actions.STORE_FLOW:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        jsonFileContent.addAll({"currentFlow": params['flow']});
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
        output.update('data', (value) {
          return jsonFileContent['currentFlow'];
        });
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
        output.update('data', (value) {
          return flow;
        });
      }
      break;
    case Actions.LIST_FLOWS:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        output.update('data', (value) {
          return jsonFileContent["flowList"];
        });

      }
      break;
    case Actions.ACTIVATE_FLOW:
      {
        Map<String, dynamic> jsonFileContent;
        jsonFileContent = json.decode(jsonFile.readAsStringSync());
        jsonFileContent["activeFlow"] = params["flow"];
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
        output.update('data', (value) {
          return jsonFileContent['activeFlow'];
        });
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

  return output;
}

Directory getDirectory() {
  Directory directory = Directory('./.conduit');
  directory.createSync();
  return directory;
}

bool onMobile = (Platform.isAndroid || Platform.isIOS);

void logit(Actions action, Map params) {
  if (onMobile) {
    return;
  }
  RandomAccessFile logFile = File(
    getDirectory().path + '/log',
  ).openSync(mode: FileMode.append);
  logFile.writeStringSync('${DateTime
      .now()
      .millisecondsSinceEpoch} $action ${params} \n');
  logFile.close();
}

void main() {
  print(performAction(Actions.SETUP_STORAGE));
  print(
      performAction(Actions.FLOW_COORDINATES, params: {'tapX': 1, 'tapY': 2}));
}
