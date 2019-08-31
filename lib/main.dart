import 'package:flow_check/name_offset_stream.dart';
import 'package:flutter/material.dart';
import 'name_stream.dart';
import 'offset_stream.dart';
import 'name_offset_stream.dart';
import 'home_page.dart' as home;
import 'flow_list_page.dart' as flow_list;

void main() => runApp(FlowCheck());

class FlowCheck extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    NameStream nameStream = NameStream();
    OffsetStream offsetStream = OffsetStream();
    NameOffsetStream nameOffsetStream = NameOffsetStream(nameStream.getResults, offsetStream.getResults);

    return MaterialApp(
        title: 'Flow Check',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => home.HomePage('Flow Check', offsetStream, nameStream),
          '/list': (_) => flow_list.FlowListPage(nameOffsetStream),
        });
  }
}
