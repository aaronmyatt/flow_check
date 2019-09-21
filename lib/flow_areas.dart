import 'package:flutter/material.dart';

class FlowAreas {
  final Size size;

  FlowAreas(this.size);

  String flowCheck(Offset offset) {
    List<FlowArea> flows = [
      FlowAnxietyArea(this.size),
      FlowDoubtArea(this.size),
      FlowNostalgiaArea(this.size),
      FlowBoredomArea(this.size),
      FlowApathyArea(this.size)
    ];
    for (FlowArea flow in flows) {
      if (flow.path.contains(offset)) {
        return flow.name;
      }
    }
    return 'flow';
  }
}

abstract class FlowArea {
  final Size size;
  final String areaName;

  FlowArea(this.size, this.areaName);

  Path get path;

  String get name => this.areaName;
}

class FlowAnxietyArea extends FlowArea {
  FlowAnxietyArea(Size size) : super(size, 'anxiety');

  Path get path {
    return Path()
      ..lineTo(0, size.height * 0.4)
      ..lineTo(size.height * 0.4, size.height * 0.4)
      ..lineTo(size.height * 0.8, 0)
      ..close();
  }
}

class FlowDoubtArea extends FlowArea {
  FlowDoubtArea(Size size) : super(size, 'doubt');

  Path get path {
    return Path()
      ..moveTo(0, size.height * 0.4)
      ..lineTo(0, size.height * 0.8)
      ..lineTo(size.height * 0.4, size.height * 0.4)
      ..close();
  }
}

class FlowNostalgiaArea extends FlowArea {
  FlowNostalgiaArea(Size size) : super(size, 'nostalgia');

  Path get path {
    return Path()
      ..moveTo(size.width * 0.2, size.height)
      ..lineTo(size.width * 0.6, size.height)
      ..lineTo(size.width * 0.6, size.height * 0.6)
      ..close();
  }
}

class FlowBoredomArea extends FlowArea {
  FlowBoredomArea(Size size) : super(size, 'boredom');

  Path get path {
    return Path()
      ..moveTo(size.width * 0.6, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height * 0.2)
      ..lineTo(size.width * 0.6, size.height * 0.6)
      ..close();
  }
}

class FlowApathyArea extends FlowArea {
  FlowApathyArea(Size size) : super(size, 'apathy');

  Path get path {
    Rect rect = Offset(0, size.height * 0.8) &
        Size(size.width * 0.2, size.height * 0.2);
    return Path()..addRect(rect);
  }
}
