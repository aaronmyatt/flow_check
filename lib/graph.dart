import 'package:flutter/material.dart';

import 'conduit/flutter_actions.dart';

class Graph extends StatefulWidget {
  State createState() => new GraphState();
}

class GraphState extends State<Graph> {
  double screenWidth;
  double tapX = 0;
  double tapY = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery
        .of(context)
        .size
        .width * 0.9;
    return _graph(context, tapX, tapY);
  }

  Widget _graph(BuildContext context, double xPos, double yPos) {
    Widget _yAxis = RotatedBox(
      quarterTurns: 3,
      child: Text('CHALLENGE', style: TextStyle(fontWeight: FontWeight.w600)),
    );

    Widget _xAxis = Text('SKILL',
        textAlign: TextAlign.justify,
        style: TextStyle(fontWeight: FontWeight.w600));

    Widget _pointer = Text(
      String.fromCharCode(Icons.details.codePoint),
      style: TextStyle(
          fontFamily: Icons.details.fontFamily,
          package: Icons.details.fontPackage,
          fontSize: 24.0,
          color: Colors.black),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _yAxis,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  Offset offset = details.localPosition;
                  if (offset == Offset(0.0, 0.0)) {} else {
                    this.setState(() {
                      tapX = offset.dx;
                      tapY = offset.dy;
                    });
                    tapFlowGraph(offset, screenWidth);
                  }
                },
                child: Container(
                  padding:
                  // -15 ensures the icon lands comfortably under where the screen is pressed.
                  EdgeInsets.only(
                      top: getYPosition(yPos), left: getXPosition(xPos)),
                  child:
                  Offset(xPos, yPos) == Offset(0.0, 0.0) ? null : _pointer,
                  width: screenWidth,
                  height: screenWidth,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 2.0,
                      ),
                      bottom: BorderSide(
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              _xAxis
            ],
          ),
        ],
      ),
    );
  }

  double getXPosition(double xPos) {
    var X = xPos - 15;
    if (X < 0) {
      return 0;
    } else {
      return X;
    }
  }

  double getYPosition(double yPos) {
    var Y = yPos - 15;
    if (Y < 0) {
      return 0;
    } else {
      return Y;
    }
  }
}
