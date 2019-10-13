import "dart:async";

import 'package:flow_check/offset_stream.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

OffsetStream offset = OffsetStream();

void main() {
  test('emits offset', () async {
    Offset offset = Offset(1.0, 1.0);

    scheduleMicrotask(() {
      OffsetStream().process(offset);
    });

    await expectLater(OffsetStream().getStream, emits(offset));
  });

  test('stream can be reset', () async {
    Offset offset = Offset(1.0, 1.0);
    Offset resetOffset = Offset(0.0, 0.0);

    scheduleMicrotask(() {
      OffsetStream().process(offset);
      OffsetStream().reset();
    });

    await expectLater(
        OffsetStream().getStream,
        emitsInOrder([
          offset,
          resetOffset,
        ]));
  });
}
