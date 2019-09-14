import 'dart:developer';
import 'package:rxdart/subjects.dart' show PublishSubject;


class NameStream {
  static final NameStream _instance = NameStream._internal();
  factory NameStream() => _instance;

  String name;
  PublishSubject<String> subject;

  NameStream._internal() {
    subject = PublishSubject<String>();
    subject.listen((String data) {
      log(data.toString(), name: "NameStream");
    });
  }


  void process(String name)
  {
    subject.sink.add(name);
  }


  Stream<String> get getStream
  {
    return subject.stream;
  }
}