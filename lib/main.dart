import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:flutter/material.dart';

import 'flow_list_page.dart' as flow_list;
import 'flow_view_page.dart' as flow_view;
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
        '/list': (_) => flow_list.FlowListPage('Flow History'),
        '/canvas': (_) => flow_view.FlowViewPage('Flow View'),
      },
    );
  }
}
