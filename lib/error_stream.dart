import 'dart:developer';
import 'package:rxdart/subjects.dart' show PublishSubject;


class AppErrorStream {
  static final AppErrorStream _instance = AppErrorStream._internal();
  factory AppErrorStream() => _instance;

  String name;
  PublishSubject<String> subject = PublishSubject<String>();

  AppErrorStream._internal() {
    subject.listen((String data) {
      log(data.toString(), name: "AppErrorStream");
    });
  }


  void process(String message)
  {
    subject.add(message);
  }


  Stream<String> get getStream
  {
    return subject.stream;
  }
}