import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
