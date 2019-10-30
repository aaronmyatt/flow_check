import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:flow_check/flow_list_page.dart' as flow_list;
import 'package:flow_check/flow_view_page.dart' as flow_view;
import 'package:flow_check/home_page.dart' as home;
import 'package:flow_check/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlowCheck());

class FlowCheck extends StatelessWidget {

  FlowCheck() {
    Conduit.performAction(Conduit.Actions.SETUP_STORAGE);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: flowCheckTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => home.HomePage('Flow Check'),
        '/list': (_) => flow_list.FlowListPage('Flow History'),
        '/canvas': (_) => flow_view.FlowViewPage('Flow View'),
      },
    );
  }
}
