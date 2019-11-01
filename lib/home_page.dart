import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:flow_check/graph.dart' as graph;
import 'package:flutter/material.dart';

import 'bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  final String pageTitle;
  final int currentIndex = 0;

  HomePage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.pageTitle),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[graph.Graph(), NameInput()],
        ),
      ),

    );
  }
}

class NameInput extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            textCapitalization: TextCapitalization.words,
            controller: textController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person, color: Theme
                  .of(context)
                  .iconTheme
                  .color,),
              hintText: 'Enter a name',
            ),
            onSubmitted: (text) {
              Conduit.performAction(Conduit.Actions.NAME_INPUT,
                  params: {"currentName": textController.text});
              Conduit.performAction(Conduit.Actions.STORE_FLOW);
            },
          ),
        ],
      ),
    );
  }
}
