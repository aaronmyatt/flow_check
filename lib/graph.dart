import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Graph extends StatelessWidget {
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width * 0.9;
    // cc:onboarding#4;Highlight the graph and how to use it;
    return DescribedFeatureOverlay(
        featureId: 'graph',
        // Unique id that identifies this overlay.
        tapTarget: const Icon(
          Icons.touch_app,
          size: 44.0,
        ),
        // The widget that will be displayed as the tap target.
        title: Text('Challenge vs Skill = Flow State'),
        description: Text(
            'Ask your report to rate their percieved Challenge vs percieved Skill by clicking inside this graph.'),
        backgroundColor: Theme.of(context).backgroundColor,
        targetColor: Colors.white,
        textColor: Colors.white,
        child: _graph(context));
  }

  Widget _graph(BuildContext context) {
    double xPos = Provider.of<ValueNotifier<Offset>>(context).value.dx;
    double yPos = Provider.of<ValueNotifier<Offset>>(context).value.dy;

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
                  // cc:create_flow#1;Store graph location in Provider
                  Offset offset = details.localPosition;
                  Provider
                      .of<ValueNotifier<Offset>>(context)
                      .value = offset;
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
