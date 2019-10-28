import 'package:flow_check/conduit/actions.dart' as Conduit;
import 'package:flow_check/graph.dart' as graph;
import 'package:flow_check/nav_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String pageTitle;

  HomePage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.pageTitle),
      ),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: <Widget>[graph.Graph(), NameInput()],
          ),
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
              prefixIcon: Icon(Icons.person),
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

class ActiveButton extends StatelessWidget {
  const ActiveButton({
    Key key,
    @required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: RaisedButton(
        child: Text('Submit Flow'),
        onPressed: () {},
      ),
    );
  }
}

class InactiveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: RaisedButton(
        child: Text('Submit Flow'),
        onPressed: null,
      ),
    );
  }
}
