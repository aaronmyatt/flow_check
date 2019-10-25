import 'package:flow_check/flow_areas.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

Size size = Size(100, 100);

void main() {
  test('should clasify offset(1,1) as anxiety', () {
    final flowAreas = FlowAreas(size.width, size.height);

    String flow = flowAreas.flowCheck(1.0, 1.0);

    expect(flow, 'anxiety');
  });

  test('should clasify offset(max,max) as boredem', () {
    final flowAreas = FlowAreas(size.width, size.height);

    String flow = flowAreas.flowCheck(size.width, size.height);

    expect(flow, 'boredom');
  });

  test('should clasify offset(0,max) as apathy', () {
    final flowAreas = FlowAreas(size.width, size.height);

    String flow = flowAreas.flowCheck(0, size.height);

    expect(flow, 'apathy');
  });

  test('should clasify offset(21%,max) as nostalgic', () {
    final flowAreas = FlowAreas(size.width, size.height);

    String flow = flowAreas.flowCheck(size.width * 0.21, size.height);

    expect(flow, 'nostalgia');
  });

  test('should clasify offset(0,79%) as doubtful', () {
    final flowAreas = FlowAreas(size.width, size.height);

    String flow = flowAreas.flowCheck(0, size.height * 0.78);

    expect(flow, 'doubt');
  });

  test('should clasify offset(max,0) as flow', () {
    final flowAreas = FlowAreas(size.width, size.height);

    String flow = flowAreas.flowCheck(size.width, 0);

    expect(flow, 'flow');
  });

  test('should clasify offset(50%, 50%) as flow', () {
    final flowAreas = FlowAreas(size.width, size.height);

    String flow =
    flowAreas.flowCheck(size.width * 0.5, size.height * 0.5);

    expect(flow, 'flow');
  });
}
