import 'package:flutter/material.dart';
import 'graph.dart' as graph;
import 'dart:developer' as developer;

class HomePage extends StatelessWidget {
  final String title;
  final offsetStream;
  final nameStream;

  HomePage(this.title, this.offsetStream, this.nameStream);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title),
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
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          graph.Graph(this.offsetStream),
          NameInput(nameStream)
        ],
      ),
    );
  }
}

class NameInput extends StatelessWidget {
  final nameStream;
  final TextEditingController textController = TextEditingController();

  NameInput(this.nameStream);

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
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: RaisedButton(
                    child: Text('Submit Flow'),
                    onPressed: () {
                      if (textController.text != null) {
                        nameStream.process(textController.text);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
