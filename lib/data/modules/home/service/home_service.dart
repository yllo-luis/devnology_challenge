import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:devnology_challenge/data/modules/home/service/home_service_contract.dart';

class HomeService implements HomeServiceContract {
  @override
  Future<EventResponse> getEvent() {
    // TODO: implement getEvent
    throw UnimplementedError();
  }

  @override
  Future<EventResponse> getEventPerParticipants({required String participants}) {
    // TODO: implement getEventPerParticipants
    throw UnimplementedError();
  }

  @override
  Future<EventResponse> getEventPerPrice({required double price}) {
    // TODO: implement getEventPerPrice
    throw UnimplementedError();
  }

  @override
  Future<EventResponse> getEventPerType({required String type}) {
    // TODO: implement getEventPerType
    throw UnimplementedError();
  }

  @override
  Future<EventResponse> getEventWithAccessibility({required double accessibility}) {
    // TODO: implement getEventWithAccessibility
    throw UnimplementedError();
  }
}