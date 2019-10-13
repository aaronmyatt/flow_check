import "dart:async";

import 'package:flow_check/flow_check_stream.dart';
import 'package:flow_check/name_stream.dart';
import 'package:flow_check/persons_flow_stream.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

FlowCheckStream fcs = FlowCheckStream();
NameStream ns = NameStream();
PersonsFlowStream nos = PersonsFlowStream();

void main() {
  test('emits PersonsFlow list', () async {
    Offset offset = Offset(1.0, 1.0);
    Size size = Size(100, 100);

    scheduleMicrotask(() {
      NameStream().process('Test');
      FlowCheckStream().process(offset, size);
    });

    await expectLater(PersonsFlowStream().getStream,
        emits((List<PersonsFlow> personsFlow) {
      return personsFlow.first.name == 'Test' &&
          personsFlow.first.flow == 'anxiety';
    }));
  });
//
//  test('accummulates data', () async {
//    Offset offset = Offset(1.0, 1.0);
//
//    scheduleMicrotask(() {
//      OffsetStream().process(offset);
//      NameStream().process('Test');
//
//      OffsetStream().process(offset);
//      NameStream().process('Test1');
//    });
//
//    await expectLater(NameOffsetStream().getStream,
//        emits((List<NameOffset> nameOffsets) {
//      return nameOffsets.length > 1;
//    }));
//  });
}
