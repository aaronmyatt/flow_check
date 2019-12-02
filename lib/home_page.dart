import 'package:feature_discovery/feature_discovery.dart';
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
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(color: Theme.of(context).backgroundColor),
        ],
      ),
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
              suffixIcon: DescribedFeatureOverlay(
                featureId: 'submit',
                tapTarget: const Icon(
                  Icons.check,
                  size: 44.0,
                  color: Colors.green,
                ),
                title: Text('Enter their name and submit.'),
                backgroundColor: Theme.of(context).backgroundColor,
                targetColor: Colors.white,
                textColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.check),
                  color: Colors.green,
                  onPressed: () {
                    if (textController.text != '') {
                      submitFlow(textController.text);
                      textController.clear();
                      Navigator.pushNamed(context, '/canvas');
                    }
                  },
                ),
              ),
              hintText: 'Enter a name',
            ),
            onSubmitted: (text) {
              if (textController.text != '') {
                submitFlow(textController.text);
                textController.clear();
                Navigator.pushNamed(context, '/canvas');
              }
            },
          ),
        ],
      ),
    );
  }
}
