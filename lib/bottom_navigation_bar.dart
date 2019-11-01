import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  BottomNavBar(this.currentIndex);

  @override
  State createState() => BottomNavBarState(currentIndex);
}

class BottomNavBarState extends State<BottomNavBar> {
  final int currentIndex;

  BottomNavBarState(this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          title: Text("Flow Check"),
          icon: Icon(Icons.touch_app),
        ),
        BottomNavigationBarItem(
          title: Text("Flow History"),
          icon: Icon(Icons.list),
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      onTap: (int item) {
        switch (item) {
          case 0:
            {
              Navigator.pushNamed(context, '/');
            }
            break;
          case 1:
            {
              Navigator.pushNamed(context, '/list');
            }
            break;
        }
      },
    );
  }
}
