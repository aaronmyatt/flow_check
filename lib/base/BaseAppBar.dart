import 'package:flutter/material.dart';

Widget BaseAppBar(pageTitle, context, {backButton: false, infoButton: true}) {
  return AppBar(
    automaticallyImplyLeading: backButton,
    title: Text(pageTitle),
    actions: actions(context, infoButton),
  );
}

List<Widget> actions(context, infoButton) {
  List<Widget> actionList = [];
  if (infoButton) {
    actionList.add(InfoButton(context));
  }
  return actionList;
}

Widget InfoButton(context) {
  return IconButton(
      icon: Icon(Icons.info),
      onPressed: () {
        Navigator.pushNamed(context, '/info');
      });
}
