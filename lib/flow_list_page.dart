import 'package:flow_check/nav_drawer.dart';
import 'package:flow_check/persons_flow_stream.dart';
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
          stream: PersonsFlowStream().getStream,
          initialData: [PersonsFlow('Test', 'Flow')],
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<PersonsFlow> items = snapshot.data;
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

  final List<PersonsFlow> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        PersonsFlow item = items[index];
        return Container(
          decoration: BoxDecoration(
              border:
              Border(bottom: BorderSide(width: 3, color: Colors.black))),
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
                  child: Center(child: Text(item.flow)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
