import 'dart:async';

import 'package:devnology_challenge/core/constants/app_constants_utils.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class HomeStore {
  late BehaviorSubject<EventResponse> eventController;
  late BehaviorSubject<int> savedEventsController;
  
  late ValueNotifier<double> accessibilityNotifier = ValueNotifier(AppConstantsUtils.minAccessibilityValue);
  late ValueNotifier<double> participantsNotifier = ValueNotifier(AppConstantsUtils.minParticipantsValue);
  late ValueNotifier<double> priceNotifier = ValueNotifier(AppConstantsUtils.minPriceValue);

  HomeStore() {
    eventController = BehaviorSubject<EventResponse>();
    savedEventsController = BehaviorSubject<int>();
  }

  void addEvent({required EventResponse response}) {
    eventController.sink.add(response);
  }

  void addCountEvent({required int countEvent}) {
    savedEventsController.sink.add(countEvent);
  }

  Stream<EventResponse> get currentEventStream => eventController.stream;
  StreamSink<EventResponse> get currentEventSink => eventController.sink;
  
  Stream<int> get savedEventsStream => savedEventsController.stream;
  StreamSink<int> get savedEventsSink => savedEventsController.sink;

  void onDispose() {
    eventController.close();
    savedEventsController.close();
  }
}