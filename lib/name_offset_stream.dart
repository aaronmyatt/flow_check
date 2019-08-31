import 'package:rxdart/subjects.dart' show ReplaySubject;
import 'package:rxdart/rxdart.dart' show ZipStream;
import 'package:flutter/widgets.dart';

class NameOffset {
  final String name;
  final Offset offset;

  NameOffset({this.name = '', this.offset = const Offset(0.0, 0.0)});
}

class NameOffsetStream {
  List<NameOffset> _state = [];
  final Stream<String> nameStream;
  final Stream<Offset> offsetStream;
  ReplaySubject<List<NameOffset>> nameOffset = ReplaySubject<List<NameOffset>>();

  NameOffsetStream(this.nameStream, this.offsetStream){
    nameOffset.add(_state);
    ZipStream.zip2(this.nameStream, this.offsetStream,
        (String name, Offset offset) {
      return NameOffset(name: name, offset: offset);
    }).listen(onData);
  }

  Stream get getResults {
    return nameOffset.stream;
  }

  void onData (NameOffset data) {
      _state.add(data);
      nameOffset.sink.add(_state);
  }
}