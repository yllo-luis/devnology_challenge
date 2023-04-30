import 'dart:async';

import 'package:devnology_challenge/core/constants/app_constants_utils.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:flutter/cupertino.dart';

class HomeStore {
  late StreamController<EventResponse> eventController;

  late ValueNotifier<double> accessibilityNotifier = ValueNotifier(AppConstantsUtils.minAccessibilityValue);
  late ValueNotifier<double> participantsNotifier = ValueNotifier(AppConstantsUtils.minParticipantsValue);
  late ValueNotifier<double> priceNotifier = ValueNotifier(AppConstantsUtils.minPriceValue);

  HomeStore() {
    eventController = StreamController.broadcast();
  }

  void addEvent({required EventResponse response}) {
    eventController.sink.add(response);
  }

  Stream<EventResponse> get currentEventStream => eventController.stream;
  StreamSink<EventResponse> get currentEventSink => eventController.sink;

  void onDispose() {
    eventController.close();
  }
}