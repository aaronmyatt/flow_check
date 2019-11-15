import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import './utils/storage.dart';

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

  Map<String, dynamic> output = {'data': {}, 'status': 'success'};
  Directory directory = params['dictory'] ?? getDirectory();
  Map<String, dynamic> jsonFileContent;

  switch (actionName) {
    case Actions.SETUP_STORAGE:
      {
        initialiseStorage(directory);
      }
      break;
    case Actions.FLOW_COORDINATES:
      {
        jsonFileContent = saveToStore(
            directory,
            'currentCoordinates',
            {'tapX': params['tapX'], 'tapY': params['tapY']});
      }
      break;
    case Actions.NAME_INPUT:
      {
        jsonFileContent = saveToStore(
            directory,
            'currentName',
            params['currentName']);
      }
      break;
    case Actions.STORE_FLOW:
      {
        jsonFileContent = saveToStore(
            directory,
            'currentFlow',
            params['currentFlow']);
      }
      break;
    case Actions.STORE_REPORT:
      {
        jsonFileContent = fetchToStore(directory);
        Map flow = {
          "name": jsonFileContent["currentName"],
          "flowType": jsonFileContent["currentFlow"],
          "coordinates": jsonFileContent["currentCoordinates"],
          "timestamp": DateTime
              .now()
              .millisecondsSinceEpoch,
        };
        List flowList = jsonFileContent["flowList"];
        flowList.add(flow);

        jsonFileContent = saveToStore(
            directory,
            'flowList',
            flowList);
      }
      break;
    case Actions.LIST_FLOWS:
      {
        jsonFileContent = fetchToStore(directory);
        output.update('data', (value) {
          return jsonFileContent["flowList"];
        });
      }
      break;
    case Actions.ACTIVATE_FLOW:
      {
        jsonFileContent = saveToStore(
            directory,
            'activeFlow',
            params["flow"]);
      }
      break;
    case Actions.ACTIVE_FLOW:
      {
        jsonFileContent = fetchToStore(directory);
      }
      break;
    default:
      {
        log('NO MATCH', name: 'DEFAULT ACTION');
      }
  }

  output.update('data', (value) {
    return jsonFileContent;
  });
  log_output(actionName, output);
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
  File jsonFile = File(getDirectory().path + '/log.json');
  bool doesNotExist = (jsonFile.existsSync() == false);

  if (doesNotExist) {
    jsonFile.createSync();
    Map<String, dynamic> jsonFileContent = {"entries": []};
    jsonFile.writeAsStringSync(json.encode(jsonFileContent));
  }

  Map entry = {
    "timestamp": DateTime
        .now()
        .millisecondsSinceEpoch,
    "action": action.toString(),
    "params": params
  };

  Map<String, dynamic> jsonFileContent;
  jsonFileContent = json.decode(jsonFile.readAsStringSync());
  jsonFileContent["entries"].add(entry);
  jsonFile.writeAsStringSync(json.encode(jsonFileContent));

  logAction(entry, 'inputs');
}

void log_output(Actions action, Map output) {
  if (onMobile) {
    return;
  }

  Map entry = {
    "timestamp": DateTime
        .now()
        .millisecondsSinceEpoch,
    "action": action.toString(),
    "params": output
  };
  log(entry.toString());
  logAction(entry, 'outputs');
}

void logAction(entry, in_out) {
  if (onMobile) {
    return;
  }
  File jsonFile = File(getDirectory().path + '/${entry['action']}.log.json');
  bool doesNotExist = (jsonFile.existsSync() == false);

  if (doesNotExist) {
    jsonFile.createSync();
    Map<String, dynamic> jsonFileContent = {'inputs': [], 'outputs': []};
    jsonFile.writeAsStringSync(json.encode(jsonFileContent));
  }
  Map<String, dynamic> jsonFileContent;
  jsonFileContent = json.decode(jsonFile.readAsStringSync());
  jsonFileContent[in_out].add(entry);
  jsonFile.writeAsStringSync(json.encode(jsonFileContent));
}

void main() {
  print(performAction(Actions.SETUP_STORAGE));
  print(
      performAction(Actions.FLOW_COORDINATES, params: {'tapX': 1, 'tapY': 2}));
  print(
      performAction(Actions.NAME_INPUT, params: {'currentName': 'Aaron'}));
  print(
      performAction(Actions.STORE_FLOW, params: {'flow': 'flow'}));
  print(
      performAction(Actions.STORE_REPORT));
  var store = fetchToStore(getDirectory());
  performAction(Actions.ACTIVATE_FLOW, params: {'flow': store['flowList'][0]});
  performAction(Actions.ACTIVE_FLOW);
}
