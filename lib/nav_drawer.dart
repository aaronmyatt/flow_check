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
            leading: Icon(Icons.touch_app),
            title: Text('Flow Check'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Flow History'),
            onTap: () {
              Navigator.pushNamed(context, '/list');
            },
          ),
        ],
      ),
    );
  }
}
