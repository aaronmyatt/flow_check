import 'dart:developer';
import 'dart:ui';

import 'package:flow_check/offset_stream.dart';
import 'package:rxdart/rxdart.dart';

import 'flow_areas.dart';

class FlowCheck {
  final Size size;

  FlowCheck(this.size);

  String flowArea(Offset offset) {
    return FlowAreas(this.size).flowCheck(offset);
  }
}

class FlowCheckStream {
  static final FlowCheckStream _instance = FlowCheckStream._internal();

  factory FlowCheckStream() => _instance;

  PublishSubject<String> subject;

  FlowCheckStream._internal() {
    subject = PublishSubject<String>();

    OffsetStream().getStream.listen((SizeOffset offset) {
      FlowCheckStream().process(offset.offset, offset.size);
    });

    subject.listen((String data) {
      log(data.toString(), name: "FlowCheckStream");
    });
  }

  void process(Offset offset, Size size) {
    if (offset == Offset.zero || size == Size.zero) {
      String flow = FlowCheck(size).flowArea(offset);
      subject.sink.add(flow);
    }
  }

  Stream<String> get getStream {
    return subject.stream;
  }
}
