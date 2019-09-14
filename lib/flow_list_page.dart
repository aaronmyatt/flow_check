import 'package:flow_check/name_offset_stream.dart';
import 'package:flutter/material.dart';

class FlowListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flow List'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('List'),
              onTap: () {
                Navigator.pushNamed(context, '/list');
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Canvas'),
              onTap: () {
                Navigator.pushNamed(context, '/canvas');
              },
            ),
          ],
        ),
      ),
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
