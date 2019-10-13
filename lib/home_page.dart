import 'package:flow_check/graph.dart' as graph;
import 'package:flow_check/name_stream.dart';
import 'package:flow_check/nav_drawer.dart';
import 'package:flow_check/offset_stream.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      drawer: NavDrawer(),
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
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: 'Enter a name',
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                  stream: OffsetStream().getStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.data == Offset(0.0, 0.0)) {
                      return InactiveButton();
                    } else {
                      return ActiveButton(textController: textController);
                    }
                  },
                ),
              ),
            ],
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
        onPressed: () {
          if (textController.text == null ||
              textController.text == "") {} else {
            NameStream().process(textController.text);
            textController.clear();
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
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
