import 'dart:io';

import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:flow_check/flow_list_page.dart' as flow_list;
import 'package:flow_check/flow_view_page.dart' as flow_view;
import 'package:flow_check/home_page.dart' as home;
import 'package:flow_check/theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(FlowCheck());

class FlowCheck extends StatelessWidget {
  FlowCheck() {
    getApplicationDocumentsDirectory().then((Directory directory) {
      Conduit.performAction(Conduit.Actions.SETUP_STORAGE,
          params: {'directory': directory});
    });
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
