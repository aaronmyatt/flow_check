import 'dart:developer';

import 'package:flutter/widgets.dart' show Offset;
import 'package:rxdart/subjects.dart' show PublishSubject;

class OffsetStream {
  static final OffsetStream _instance = OffsetStream._internal();

  factory OffsetStream() => _instance;

  String name;
  PublishSubject<Offset> subject;

  OffsetStream._internal() {
    subject = PublishSubject<Offset>();
    subject.listen((Offset data) {
      log(data.toString(), name: "OffsetStream");
    });
  }

  void process(Offset offset) {
    subject.sink.add(offset);
  }

  Stream<Offset> get getStream {
    return subject.stream;
  }

  void reset() {
    OffsetStream().process(Offset(0.0, 0.0));
  }
}
