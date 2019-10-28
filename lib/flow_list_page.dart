import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:flow_check/nav_drawer.dart';
import 'package:flutter/material.dart';

class FlowListPage extends StatelessWidget {
  final String pageTitle;

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
                drawer: NavDrawer(),
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
        return Container(
          decoration: BoxDecoration(
              border:
              Border(bottom: BorderSide(width: 3, color: Colors.black))),
          child: GestureDetector(
            onTap: () {
              Conduit.performAction(Conduit.Actions.ACTIVATE_FLOW,
                  params: {"flow": item});
              Navigator.pushNamed(context, '/canvas');
            },
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.lightBlueAccent,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.4,
                  child: Center(child: Text(item["name"])),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.cyanAccent,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4,
                    child: Center(child: Text(item["flowType"])),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
