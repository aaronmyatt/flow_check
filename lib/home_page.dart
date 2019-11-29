import 'package:flow_check/base/BaseAppBar.dart';
import 'package:flow_check/graph.dart' as graph;
import 'package:flutter/material.dart';

import 'bottom_navigation_bar.dart';
import 'conduit/flutter_actions.dart';

class HomePage extends StatelessWidget {
  final String pageTitle;
  final int currentIndex = 0;

  HomePage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(this.pageTitle, context),
      bottomNavigationBar: BottomNavBar(currentIndex),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            graph.Graph(),
            NameInput(),
            RaisedButton.icon(
                icon: Icon(Icons.info),
                label: Text('Learn More'),
                onPressed: () {
                  Navigator.pushNamed(context, '/info');
                }),
          ],
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
              prefixIcon: Icon(
                Icons.person,
                color: Theme.of(context).iconTheme.color,
              ),
              hintText: 'Enter a name',
            ),
            onSubmitted: (text) {
              submitFlow(textController.text);
              textController.clear();
              Navigator.pushNamed(context, '/canvas');
            },
          ),
        ],
      ),
    );
  }
}
