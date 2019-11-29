import 'dart:io';

import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:path_provider/path_provider.dart';

import '../flow_areas.dart';

void tapFlowGraph(offset, screenWidth) {
  getApplicationDocumentsDirectory().then((Directory directory) {
    Conduit.flowCoordinates(offset.dx, offset.dy, dir: directory);
    String flowType =
    FlowAreas(screenWidth, screenWidth).flowCheck(offset.dx, offset.dy);
    Conduit.storeFlow(flowType, dir: directory);
  });
}

void submitFlow(text) {
  getApplicationDocumentsDirectory().then((Directory directory) {
    Conduit.nameInput(text, dir: directory);
    Map output = Conduit.storeReport(dir: directory);
    List flowList = output["flowList"];
    var latestFlow = flowList.last;
    Conduit.activateFlow(latestFlow, dir: directory);
  });
}
