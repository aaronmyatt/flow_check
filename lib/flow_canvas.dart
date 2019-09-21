import 'package:flow_check/flow_areas.dart';
import 'package:flow_check/nav_drawer.dart';
import 'package:flutter/material.dart';

class FlowCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width * 0.9;

    return Scaffold(
        appBar: AppBar(
          title: Text('Flow List'),
        ),
        drawer: NavDrawer(),
        body: Container(
          child: CustomPaint(
            painter: FlowShapes(),
          ),
          width: width,
          height: width,
        ));
  }
}

class FlowShapes extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    canvas.drawRect(rect, Paint()
      ..color = Colors.yellow);

    canvas.drawPath(FlowAnxietyArea(size).path, Paint()
      ..color = Colors.black);
    canvas.drawPath(FlowDoubtArea(size).path, Paint()
      ..color = Colors.blue);
    canvas.drawPath(FlowNostalgiaArea(size).path, Paint()
      ..color = Colors.blue);
    canvas.drawPath(FlowBoredomArea(size).path, Paint()
      ..color = Colors.black);
    canvas.drawPath(FlowApathyArea(size).path, Paint()
      ..color = Colors.red);
  }

  @override
  bool shouldRepaint(FlowShapes oldDelegate) => false;
}
