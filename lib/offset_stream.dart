import 'dart:developer';

import 'package:flutter/widgets.dart' show Offset;
import 'package:flutter/widgets.dart' show Size;
import 'package:rxdart/subjects.dart' show PublishSubject;

class SizeOffset {
  Offset offset;
  Size size;

  SizeOffset(this.offset, this.size);
}

class OffsetStream {
  static final OffsetStream _instance = OffsetStream._internal();

  factory OffsetStream() => _instance;

  String name;
  PublishSubject<SizeOffset> subject;

  OffsetStream._internal() {
    subject = PublishSubject<SizeOffset>();
    subject.listen((SizeOffset data) {
      log(data.toString(), name: "OffsetStream");
    });
  }

  void process(Offset offset, {Size size: Size.zero}) {
    subject.sink.add(SizeOffset(offset, size));
  }

  Stream<SizeOffset> get getStream {
    return subject.stream;
  }

  void reset() {
    OffsetStream().process(Offset.zero);
  }
}
