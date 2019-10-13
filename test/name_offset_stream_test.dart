import "dart:async";

import 'package:flow_check/name_offset_stream.dart';
import 'package:flow_check/name_stream.dart';
import 'package:flow_check/offset_stream.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

OffsetStream o = OffsetStream();
NameStream ns = NameStream();
NameOffsetStream nos = NameOffsetStream();

void main() {
  test('emits NameOffset instances', () async {
    Offset offset = Offset(1.0, 1.0);

    scheduleMicrotask(() {
      OffsetStream().process(offset);
      NameStream().process('Test');
    });

    await expectLater(NameOffsetStream().getStream,
        emits((List<NameOffset> nameOffsets) {
      return nameOffsets.first is NameOffset;
    }));
  });

  test('emits NameOffset list', () async {
    Offset offset = Offset(1.0, 1.0);

    scheduleMicrotask(() {
      OffsetStream().process(offset);
      NameStream().process('Test');
    });

    await expectLater(NameOffsetStream().getStream,
        emits((List<NameOffset> nameOffsets) {
      return nameOffsets.first.name == 'Test' &&
          nameOffsets.first.offset == offset;
    }));
  });

  test('accummulates data', () async {
    Offset offset = Offset(1.0, 1.0);

    scheduleMicrotask(() {
      OffsetStream().process(offset);
      NameStream().process('Test');

      OffsetStream().process(offset);
      NameStream().process('Test1');
    });

    await expectLater(NameOffsetStream().getStream,
        emits((List<NameOffset> nameOffsets) {
      return nameOffsets.length > 1;
    }));
  });
}
