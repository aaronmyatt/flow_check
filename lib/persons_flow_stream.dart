import 'dart:developer';

import 'package:flow_check/flow_check_stream.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/rxdart.dart' show ZipStream;
import 'package:rxdart/subjects.dart' show BehaviorSubject;

import 'name_stream.dart';
import 'offset_stream.dart';

class PersonsFlow {
  final String name;
  final String flow;

  PersonsFlow(this.name, this.flow);

  @override
  String toString() {
    return "$name :: $flow";
  }
}

class PersonsFlowStream {
  static final PersonsFlowStream _instance = PersonsFlowStream._internal();

  factory PersonsFlowStream() => _instance;

  List<PersonsFlow> _state = [];
  BehaviorSubject<List<PersonsFlow>> subject;

  PersonsFlowStream._internal() {
    subject = BehaviorSubject<List<PersonsFlow>>();
    ZipStream.zip2<String, String, PersonsFlow>(
      NameStream().getStream,
      FlowCheckStream().getStream,
      _buildPersonsFlow,
    ).listen(onData);
  }

  Stream get getStream {
    return subject.stream;
  }

  void onData(PersonsFlow data) {
    _state.add(data);
    for (PersonsFlow i in _state) {
      log(i.toString(), name: "PersonsFlowStream::onData");
    }
    subject.sink.add(_state);

    OffsetStream().reset();
  }

  PersonsFlow _buildPersonsFlow(String name, String flow) {
    return PersonsFlow(name, flow);
  }
}
