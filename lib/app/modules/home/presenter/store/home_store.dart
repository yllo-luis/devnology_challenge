import 'dart:async';

import 'package:devnology_challenge/data/modules/home/response/event_response.dart';

class HomeStore {
  late StreamController<EventResponse> eventController;
  late StreamController<double> accessibilityController;
  late StreamController<int> participantsController;
  late StreamController<double> priceController;

  HomeStore() {
    eventController = StreamController.broadcast();
    accessibilityController = StreamController.broadcast();
    participantsController = StreamController.broadcast();
    priceController = StreamController.broadcast();
  }

  void addEvent({required EventResponse response}) {
    eventController.sink.add(response);
  }

  Stream<EventResponse> get currentEventStream => eventController.stream;
  StreamSink<EventResponse> get currentEventSink => eventController.sink;

  void onDispose() {
    eventController.close();
    accessibilityController.close();
    participantsController.close();
    priceController.close();
  }
}