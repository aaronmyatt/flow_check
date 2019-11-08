import 'dart:io';

import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:strings/strings.dart';

import 'bottom_navigation_bar.dart';

const ONE_MINUTE = 60000;
const ONE_DAY = 86400000;

class FlowListPage extends StatelessWidget {
  final String pageTitle;
  final int currentIndex = 1;

  FlowListPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getApplicationDocumentsDirectory().then((Directory directory) {
          return Conduit.performAction(Conduit.Actions.LIST_FLOWS,
              params: {'directory': directory});
        }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting result...');
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(pageTitle),
                ),
                bottomNavigationBar: BottomNavBar(currentIndex),
                body: FlowList(items: snapshot.data),
              );
          }
          return null;
        });
  }
}

class FlowList extends StatelessWidget {
  const FlowList({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        var item = items[index];
        return ListTile(
          onTap: () {
            getApplicationDocumentsDirectory().then((Directory directory) {
              Conduit.performAction(Conduit.Actions.ACTIVATE_FLOW,
                  params: {'flow': item, 'directory': directory});
              Navigator.pushNamed(context, '/canvas');
            });
          },
          leading: Icon(
            Icons.face,
            size: 45.0,
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(capitalize(item["name"])),
              ),
              timeAgo(item["timestamp"]),
              Icon(Icons.chevron_right),
            ],
          ),
          subtitle: Text(
            "Feeling: ${capitalize(item["flowType"])}",
          ),
        );
      },
    );
  }
}

Widget timeAgo(int timestamp) {
  if (timestamp == null) return Text('');
  int now = DateTime
      .now()
      .millisecondsSinceEpoch;
  if (((now - timestamp) / ONE_MINUTE) < 6) return Text('Just Now');
  print(((now - timestamp) / ONE_DAY));
  if (((now - timestamp) / ONE_DAY) >= 1)
    return Text('${((now - timestamp) / ONE_DAY)} Days Ago');
  return Text('Today');
}
