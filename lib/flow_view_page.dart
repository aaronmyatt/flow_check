import 'dart:convert';
import 'dart:ui';

import 'package:flow_check/base/BaseAppBar.dart';
import 'package:flow_check/bottom_navigation_bar.dart';
import 'package:flow_check/flow_areas.dart';
import 'package:flow_check/services/actions.dart' as Conduit;
import 'package:flow_check/services/flow_list_service.dart' as flow_service;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:strings/strings.dart';

class FlowViewPage extends StatelessWidget {
  final String pageTitle;
  final flow_service.Flow flow;

  FlowViewPage(this.pageTitle, this.flow);

  @override
  Widget build(BuildContext context) {
    Widget shapes;
    if (flow.flowType == 'flow') {
      shapes = CustomPaint(
        painter: AllShapes(),
      );
    } else {
      shapes = CustomPaint(
        painter: FlowShape(flow.flowType),
      );
    }
    return Scaffold(
      appBar: BaseAppBar(this.pageTitle, context, backButton: true),
      bottomNavigationBar: BottomNavBar(1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black87, width: 2.0),
                    boxShadow: kElevationToShadow[2]),
                margin: EdgeInsets.only(top: 20.0),
                child: shapes,
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  SvgPicture.asset(
                    Conduit.flowTypeIconPath(flow.flowType),
                    color: Colors.black,
                    width: 60.0,
                    height: 60.0,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "${flow.name} could be in a state of: ${capitalize(flow.flowType)}",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString("assets/${flow.flowType}.json"),
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
                            return Text(json
                                .decode(snapshot.data)["text"]
                                .replaceAll('\$name', flow.name));
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlowShape extends CustomPainter {
  String flowType;

  FlowShape(this.flowType);

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var flowArea = activeFlowArea(size.width, size.height);

    canvas.drawRect(rect, Paint()..color = Colors.black12);

    canvas.drawPath(flowArea.path, Paint()..color = Colors.black54);
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
