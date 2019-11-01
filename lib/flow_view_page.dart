import 'package:flow_check/bottom_navigation_bar.dart';
import 'package:flow_check/flow_areas.dart';
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
                bottomNavigationBar: BottomNavBar(1),
                body: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        child: shapes,
                        width: width,
                        height: width,
                      ),
                    ),
                    Text(
                      "In a state of: ${flowType.toUpperCase()}",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
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
      ..color = Color(0xFFF2F1F0));

    canvas.drawPath(flowArea.path, Paint()
      ..color = Color(0xFF0477BF));
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
      ..color = Color(0xFF0477BF));

    canvas.drawPath(FlowAnxietyArea(size.width, size.height).path,
        Paint()
          ..color = Color(0xFFF2F1F0));
    canvas.drawPath(FlowDoubtArea(size.width, size.height).path,
        Paint()
          ..color = Color(0xFFF2F1F0));
    canvas.drawPath(FlowNostalgiaArea(size.width, size.height).path,
        Paint()
          ..color = Color(0xFFF2F1F0));
    canvas.drawPath(FlowBoredomArea(size.width, size.height).path,
        Paint()
          ..color = Color(0xFFF2F1F0));
    canvas.drawPath(FlowApathyArea(size.width, size.height).path,
        Paint()
          ..color = Color(0xFF0477BF));
  }

  @override
  bool shouldRepaint(AllShapes oldDelegate) => false;
}
