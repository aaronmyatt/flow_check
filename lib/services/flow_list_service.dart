import 'dart:convert';

import 'package:flow_check/services/local_storage_service.dart';

class Flow {
  final double tapX;
  final double tapY;
  final String name;
  final String flowType;
  int timestamp;

  Flow(this.name, this.tapX, this.tapY, this.flowType, {int timestamp: 0}) {
    // cc:create_flow#4;Add a timestamp
    if (timestamp > 0) {
    } else {
      this.timestamp = DateTime.now().millisecondsSinceEpoch;
    }
    // cc:create_flow#5;TODO;Determine flow
  }

  String toJson() {
    return json.encode({
      "timestamp": timestamp,
      "name": name,
      "flowType": flowType,
      "tapX": tapX,
      "tapY": tapX,
    });
  }

  static Flow fromJson(flowString) {
    Map flow = json.decode(flowString);
    return Flow(flow["name"], flow["tapX"], flow["tapY"], flow["flowType"],
        timestamp: flow["timestamp"] ?? 0);
  }
}

class FlowListService {
  List<Flow> flows = [];

  FlowListService(this.flows);

  // cc:list_flows#1;All flows in memory
  List<Flow> get allFlows {
    return flows;
  }

  FlowListService add(String name, double tapX, double tapY, String flowType) {
    // cc:create_flow#3;Build a new Flow
    Flow flow = Flow(name, tapX, tapY, flowType);
    // cc:create_flow#6;Update the Flow list
    flows.add(flow);

    // cc:create_flow#7;TODO;Save Flow list state to file
    LocalStorageService.save(this.toJson());
    return this;
  }

  String toJson() {
    Map appStore = {"flowList": []};
    appStore["flowList"] = flows.map((flow) {
      return flow.toJson();
    }).toList();
    return json.encode(appStore);
  }

  static FlowListService fromJson(String store) {
    Map appStore = json.decode(store);
    List<Flow> flowList;
    try {
      flowList = List.generate(appStore["flowList"].length, (index) {
        return Flow.fromJson(appStore["flowList"][index]);
      });
      return FlowListService(flowList);
    } on TypeError catch (e) {
      print(e);
      return FlowListService(<Flow>[]);
    }
  }
}
