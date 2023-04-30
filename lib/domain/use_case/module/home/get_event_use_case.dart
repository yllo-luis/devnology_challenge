import 'dart:developer';

import 'package:devnology_challenge/data/modules/home/service/home_service_contract.dart';

import '../../../../data/modules/home/response/event_response.dart';

class GetEventUseCase {
  final HomeServiceContract homeService;

  GetEventUseCase({required this.homeService});

  Future<EventResponse> getEvent() async {
    EventResponse response = await homeService.getEvent();
    return response;
  }
}