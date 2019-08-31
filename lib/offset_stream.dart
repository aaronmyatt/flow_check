import 'package:flutter/widgets.dart';
import 'package:rxdart/subjects.dart' show ReplaySubject;

class OffsetStream {
  ReplaySubject<Offset> subject = ReplaySubject<Offset>();

  void process(Offset offset)
  {
    subject.add(offset);
  }


  Stream<Offset> get getResults
  {
    return subject.stream;
  }
}