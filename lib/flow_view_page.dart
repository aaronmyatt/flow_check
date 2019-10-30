import 'package:flow_check/flow_areas.dart';
import 'package:flow_check/nav_drawer.dart';
import 'package:flutter/material.dart';

import 'conduit/actions.dart' as Conduit;

class FlowViewPage extends StatelessWidget {
  final String pageTitle;

  FlowViewPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width * 0.9;

    return FutureBuilder(
        future: Conduit.performAction(Conduit.Actions.ACTIVE_FLOW),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting result...');
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');

              String flowType = snapshot.data["flowType"];
              Widget shapes;
              if (flowType == 'flow') {
                shapes = CustomPaint(
                  painter: AllShapes(),
                );
              } else {
                shapes = CustomPaint(
                  painter: FlowShape(flowType),
                );
              }

              return Scaffold(
                appBar: AppBar(
                  title: Text(pageTitle),
                ),
                drawer: NavDrawer(),
                body: Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Back'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Center(
                      child: Container(
                        child: shapes,
                        width: width,
                        height: width,
                      ),
                    ),
                    Text(flowType.toUpperCase()),
                  ],
                ),
              );
          }
          return null;
        });
  }
}

class FlowShape extends CustomPainter {
  String flowType;

  FlowShape(this.flowType);

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var flowArea = activeFlowArea(size.width, size.height);

    canvas.drawRect(rect, Paint()
      ..color = Colors.yellow);

    canvas.drawPath(flowArea.path, Paint()
      ..color = Colors.black);
  }

  activeFlowArea(width, height) {
    return allAreas(width, height).singleWhere((FlowArea area) {
      return area.name == this.flowType;
    });
  }

  List<FlowArea> allAreas(width, height) {
    return [
      FlowAnxietyArea(width, height),
      FlowDoubtArea(width, height),
      FlowNostalgiaArea(width, height),
      FlowBoredomArea(width, height),
      FlowApathyArea(width, height),
    ];
  }

  @override
  bool shouldRepaint(FlowShape oldDelegate) => false;
}

class AllShapes extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    canvas.drawRect(rect, Paint()
      ..color = Colors.yellow);

    canvas.drawPath(FlowAnxietyArea(size.width, size.height).path,
        Paint()
          ..color = Colors.black);
    canvas.drawPath(FlowDoubtArea(size.width, size.height).path,
        Paint()
          ..color = Colors.blue);
    canvas.drawPath(FlowNostalgiaArea(size.width, size.height).path,
        Paint()
          ..color = Colors.blue);
    canvas.drawPath(FlowBoredomArea(size.width, size.height).path,
        Paint()
          ..color = Colors.black);
    canvas.drawPath(FlowApathyArea(size.width, size.height).path,
        Paint()
          ..color = Colors.red);
  }

  @override
  bool shouldRepaint(AllShapes oldDelegate) => false;
}
