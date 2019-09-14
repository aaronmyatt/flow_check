import 'package:flutter/material.dart';

class FlowCanvas extends StatelessWidget {
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
      body: Text('Flow Canvas'),
    );
  }
}
