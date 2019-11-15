import 'dart:io';

import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:path_provider/path_provider.dart';

import '../flow_areas.dart';

void tapFlowGraph(offset, screenWidth) {
  getApplicationDocumentsDirectory().then((Directory directory) {
    Conduit.performAction(Conduit.Actions.FLOW_COORDINATES,
        params: {'tapX': offset.dx, 'tapY': offset.dy, 'directory': directory});
    String flowType =
    FlowAreas(screenWidth, screenWidth).flowCheck(offset.dx, offset.dy);
    Conduit.performAction(Conduit.Actions.STORE_FLOW,
        params: {'currentFlow': flowType, 'directory': directory});
  });
}

void submitFlow(text) {
  getApplicationDocumentsDirectory().then((Directory directory) {
    Conduit.performAction(Conduit.Actions.NAME_INPUT,
        params: {'currentName': text, 'directory': directory});
    Map output = Conduit.performAction(Conduit.Actions.STORE_REPORT,
        params: {'directory': directory});
    List flowList = output['data']['flowList'];
    var latestFlow = flowList.last;
    Conduit.performAction(Conduit.Actions.ACTIVATE_FLOW,
        params: {"flow": latestFlow, 'directory': directory});
  });
}
