import "dart:async";

import 'package:flow_check/flow_check_stream.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  test('emits list of flows', () async {
    Offset offset = Offset(1.0, 1.0);
    Size size = Size(100, 100);

    scheduleMicrotask(() {
      FlowCheckStream().process(offset, size);
    });

    await expectLater(FlowCheckStream().getStream, emits('anxiety'));
  });
}
