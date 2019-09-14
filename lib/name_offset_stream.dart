import 'dart:developer';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart' show BehaviorSubject;
import 'package:rxdart/rxdart.dart' show ZipStream;
import 'package:flutter/widgets.dart';

import 'name_stream.dart';
import 'offset_stream.dart';

class NameOffset {
  final String name;
  final Offset offset;

  NameOffset({this.name = '', this.offset})
      : assert(offset != Offset(0.0, 0.0));

  @override
  String toString() {
    return "$name :: X=${offset.dx}/Y=${offset.dy}";
  }
}

class NameOffsetStream {
  static final NameOffsetStream _instance = NameOffsetStream._internal();

  factory NameOffsetStream() => _instance;

  List<NameOffset> _state = [];
  BehaviorSubject<List<NameOffset>> subject =
      BehaviorSubject<List<NameOffset>>();

  NameOffsetStream._internal() {
    ZipStream.zip2(
      NameStream().getStream,
      OffsetStream().getStream.where((Offset offset) {
        return offset != Offset.zero;
      }),
      _buildNameOffset,
    ).listen(onData);
  }

  Stream get getStream {
    return subject.stream;
  }

  void onData(NameOffset data) {
    _state.add(data);
    for (NameOffset i in _state) {
      log(i.toString(), name: "NameOffsetStream::onData");
    }
    subject.sink.add(_state);

    OffsetStream().reset();
  }

  NameOffset _buildNameOffset(String name, Offset offset) {
    return NameOffset(name: name, offset: offset);
  }
}
