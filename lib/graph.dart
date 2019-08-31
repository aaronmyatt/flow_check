import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  final offsetStream;

  Graph(this.offsetStream);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: offsetStream.getResults,
        builder: (BuildContext context, AsyncSnapshot<Offset> snapshot) {
          return _graph(context, snapshot.data ?? Offset(0, 0));
        });
  }

  Widget _graph(BuildContext context, Offset tapPosition) {
    Widget _yAxis = RotatedBox(
      quarterTurns: 3,
      child: Text('CHALLENGE', style: TextStyle(fontWeight: FontWeight.w600)),
    );

    Widget _xAxis = Text('SKILL',
        textAlign: TextAlign.justify,
        style: TextStyle(fontWeight: FontWeight.w600));

    Widget _pointer2 = Text(
      String.fromCharCode(Icons.details.codePoint),
      style: TextStyle(
          fontFamily: Icons.details.fontFamily,
          package: Icons.details.fontPackage,
          fontSize: 24.0,
          color: Colors.black),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _yAxis,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                offsetStream.process(details.localPosition);
              },
              child: Container(
                padding:
                    // -15 ensures the icon lands comfortably under where the screen is pressed.
                    EdgeInsets.only(
                        top: getYPosition(tapPosition),
                        left: getXPosition(tapPosition)),
                child: _pointer2,
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 1.0), width: 2.0),
                    bottom: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 1.0), width: 2.0),
                  ),
                ),
              ),
            ),
            _xAxis
          ],
        ),
      ],
    );
  }

  double getXPosition(Offset tapPosition) {
    var X = tapPosition.dx - 15;
    if (X < 0) {
      return 0;
    } else {
      return X;
    }
  }

  double getYPosition(Offset tapPosition) {
    var Y = tapPosition.dy - 15;
    if (Y < 0) {
      return 0;
    } else {
      return Y;
    }
  }
}
