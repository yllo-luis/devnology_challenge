import 'dart:async';

import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:rxdart/rxdart.dart';

class SavedEventsStore {
  late BehaviorSubject<List<EventResponse>> eventsController;

  SavedEventsStore() {
    eventsController = BehaviorSubject<List<EventResponse>>();
  }

  void addEvents({required List<EventResponse> events}) {
    eventsController.sink.add(events);
  }

  Stream<List<EventResponse>> get currentEventsStream => eventsController.stream;
  StreamSink<List<EventResponse>> get currentEventsSink => eventsController.sink;

  void onDispose() {
    eventsController.close();
  }
}