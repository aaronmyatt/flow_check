import 'dart:convert';

import 'package:flow_check/base/BaseAppBar.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar.dart';

class FlowInfoPage extends StatelessWidget {
  final String pageTitle;

  FlowInfoPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString("assets/flow.json"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: Text('...'),
              );
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              Map content = json.decode(snapshot.data);
              String name = 'Aaron';
              return Scaffold(
                appBar: BaseAppBar(pageTitle, context,
                    backButton: true, infoButton: false),
                bottomNavigationBar: BottomNavBar(1),
                body: Text(content['text'].replaceAll("\$name", name)),
              );
          }
          return null;
        });
  }
}
