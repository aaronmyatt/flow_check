import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:flutter/material.dart';

import 'flow_canvas.dart' as canvas;
import 'flow_list_page.dart' as flow_list;
import 'home_page.dart' as home;

void main() => runApp(FlowCheck());

class FlowCheck extends StatelessWidget {

  FlowCheck() {
    Conduit.performAction(Conduit.Actions.SETUP_STORAGE);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flow Check',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => home.HomePage('Flow Check'),
        '/list': (_) => flow_list.FlowListPage(),
        '/canvas': (_) => canvas.FlowCanvas(),
      },
    );
  }
}
