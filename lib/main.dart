import 'package:flutter/material.dart';

import 'error_stream.dart';
import 'flow_canvas.dart' as canvas;
import 'flow_list_page.dart' as flow_list;
import 'home_page.dart' as home;
import 'name_offset_stream.dart';
import 'name_stream.dart';
import 'offset_stream.dart';

void main() => runApp(FlowCheck());

class FlowCheck extends StatelessWidget {
  FlowCheck() {
    AppErrorStream();
    NameStream();
    OffsetStream();
    NameOffsetStream();
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
        });
  }
}
