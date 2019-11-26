import 'dart:io';

import 'package:flow_check/bottom_navigation_bar.dart';
import 'package:flow_check/flow_areas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:strings/strings.dart';

import 'conduit/actions.dart' as Conduit;

class FlowViewPage extends StatelessWidget {
  final String pageTitle;

  FlowViewPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getApplicationDocumentsDirectory().then((Directory directory) {
          Map output = Conduit.getStore(dir: directory);
          return output['activeFlow'];
        }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: Text('...'),
              );
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');

              String flowType = snapshot.data["flowType"];
              String name = snapshot.data["name"];
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
                  title: Text("$name's Flow"),
                ),
                bottomNavigationBar: BottomNavBar(1),
                body: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        child: shapes,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        Conduit.flowTypeIconPath(flowType),
                        color: Colors.black,
                        width: 60.0,
                        height: 60.0,
                      ),
                    ),
                    Text(
                      "${name} could be in a state of: ${capitalize(flowType)}",
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
      ..color = Colors.black12);

    canvas.drawPath(flowArea.path, Paint()
      ..color = Colors.black54);
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
      ..color = Colors.white);

    canvas.drawPath(FlowAnxietyArea(size.width, size.height).path,
        Paint()
          ..color = Colors.black45);
    canvas.drawPath(FlowDoubtArea(size.width, size.height).path,
        Paint()
          ..color = Colors.black45);
    canvas.drawPath(FlowNostalgiaArea(size.width, size.height).path,
        Paint()
          ..color = Colors.black45);
    canvas.drawPath(FlowBoredomArea(size.width, size.height).path,
        Paint()
          ..color = Colors.black45);
    canvas.drawPath(FlowApathyArea(size.width, size.height).path,
        Paint()
          ..color = Colors.black45);
  }

  @override
  bool shouldRepaint(AllShapes oldDelegate) => false;
}
