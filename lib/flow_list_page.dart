import 'package:flow_check/name_offset_stream.dart';
import 'package:flow_check/nav_drawer.dart';
import 'package:flutter/material.dart';

class FlowListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flow List'),
      ),
      drawer: NavDrawer(),
      body: StreamBuilder(
          stream: NameOffsetStream().getStream,
          initialData: [NameOffset(name: "Aaron", offset: Offset(1.0, 1.0))],
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<NameOffset> items = snapshot.data;
            return new FlowList(items: items);
          }),
    );
  }
}

class FlowList extends StatelessWidget {
  const FlowList({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<NameOffset> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        NameOffset item = items[index];
        return Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 3, color: Colors.black))),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.lightBlueAccent,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Center(child: Text(item.name)),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.cyanAccent,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Center(child: Text(item.offset.toString())),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
