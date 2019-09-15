import 'package:flutter/material.dart';

class FlowCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flow List'),
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
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Canvas'),
                onTap: () {
                  Navigator.pushNamed(context, '/canvas');
                },
              ),
            ],
          ),
        ),
        body: Container(
          child: CustomPaint(
            painter: FlowShapes(),
          ),
          width: MediaQuery
              .of(context)
              .size
              .width * 0.9,
          height: MediaQuery
              .of(context)
              .size
              .width * 0.9,
        ));
  }
}

class FlowShapes extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    canvas.drawRect(rect, Paint()
      ..color = Colors.yellow);

    Path anxietyArea = Path()
      ..lineTo(0, size.height * 0.4)..lineTo(
          size.height * 0.4, size.height * 0.4)..lineTo(size.height * 0.8, 0)
      ..close();

    Path doubtArea = Path()
      ..moveTo(0, size.height * 0.4)
      ..lineTo(0, size.height * 0.8)..lineTo(
          size.height * 0.4, size.height * 0.4)
      ..close();

    Path nostalgiaArea = Path()
      ..moveTo(size.width * 0.2, size.height)
      ..lineTo(size.width * 0.6, size.height)..lineTo(
          size.width * 0.6, size.height * 0.6)
      ..close();

    Path boredemArea = Path()
      ..moveTo(size.width * 0.6, size.height)
      ..lineTo(size.width, size.height)..lineTo(
          size.width, size.height * 0.2)..lineTo(
          size.width * 0.6, size.height * 0.6)
      ..close();

    Rect apathyArea =
    Offset(0, size.height * 0.8) & Size(size.width * 0.2, size.height);

    canvas.drawPath(anxietyArea, Paint()
      ..color = Colors.black);
    canvas.drawPath(doubtArea, Paint()
      ..color = Colors.blue);
    canvas.drawPath(nostalgiaArea, Paint()
      ..color = Colors.blue);
    canvas.drawPath(boredemArea, Paint()
      ..color = Colors.black);
    canvas.drawRect(apathyArea, Paint()
      ..color = Colors.white);
  }

  @override
  bool shouldRepaint(FlowShapes oldDelegate) => false;
}
