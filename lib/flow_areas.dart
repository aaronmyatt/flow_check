import 'package:flutter/material.dart';

class FlowAreas {
  final double width;
  final double height;

  FlowAreas(this.width, this.height);

  String flowCheck(double x, double y) {
    List<FlowArea> flows = [
      FlowAnxietyArea(this.width, this.height),
      FlowDoubtArea(this.width, this.height),
      FlowNostalgiaArea(this.width, this.height),
      FlowBoredomArea(this.width, this.height),
      FlowApathyArea(this.width, this.height)
    ];
    for (FlowArea flow in flows) {
      if (flow.path.contains(Offset(x, y))) {
        return flow.name;
      }
    }
    return 'flow';
  }
}

abstract class FlowArea {
  final double width;
  final double height;
  final String areaName;

  FlowArea(this.width, this.height, this.areaName);

  Path get path;

  String get name => this.areaName;
}

class FlowAnxietyArea extends FlowArea {
  FlowAnxietyArea(width, height) : super(width, height, 'anxiety');

  Path get path {
    return Path()
      ..lineTo(0, height * 0.4)..lineTo(height * 0.4, height * 0.4)..lineTo(
          height * 0.8, 0)
      ..close();
  }
}

class FlowDoubtArea extends FlowArea {
  FlowDoubtArea(width, height) : super(width, height, 'doubt');

  Path get path {
    return Path()
      ..moveTo(0, height * 0.4)
      ..lineTo(0, height * 0.8)..lineTo(height * 0.4, height * 0.4)
      ..close();
  }
}

class FlowNostalgiaArea extends FlowArea {
  FlowNostalgiaArea(width, height) : super(width, height, 'nostalgia');

  Path get path {
    return Path()
      ..moveTo(width * 0.2, height)
      ..lineTo(width * 0.6, height)..lineTo(width * 0.6, height * 0.6)
      ..close();
  }
}

class FlowBoredomArea extends FlowArea {
  FlowBoredomArea(width, height) : super(width, height, 'boredom');

  Path get path {
    return Path()
      ..moveTo(width * 0.6, height)
      ..lineTo(width, height)..lineTo(width, height * 0.2)..lineTo(
          width * 0.6, height * 0.6)
      ..close();
  }
}

class FlowApathyArea extends FlowArea {
  FlowApathyArea(width, height) : super(width, height, 'apathy');

  Path get path {
    Rect rect = Offset(0, height * 0.8) &
    Size(width * 0.2, height * 0.2);
    return Path()..addRect(rect);
  }
}
