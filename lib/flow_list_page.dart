import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

import 'bottom_navigation_bar.dart';

class FlowListPage extends StatelessWidget {
  final String pageTitle;
  final int currentIndex = 1;

  FlowListPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Conduit.performAction(Conduit.Actions.LIST_FLOWS),
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
            Conduit.performAction(Conduit.Actions.ACTIVATE_FLOW,
                params: {"flow": item});
            Navigator.pushNamed(context, '/canvas');
          },
          title: Text(
              capitalize(item["name"])
          ),
          subtitle: Text(
            "Feeling: ${capitalize(item["flowType"])}",
          ),
          trailing: IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: null,
          ),
        );
      },
    );
  }
}
