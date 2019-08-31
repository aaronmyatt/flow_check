import 'package:rxdart/subjects.dart' show ReplaySubject;


class NameStream {
  ReplaySubject<String> subject = ReplaySubject<String>();

  void process(String name)
  {
    subject.add(name);
  }


  Stream<String> get getResults
  {
    return subject.stream;
  }
}