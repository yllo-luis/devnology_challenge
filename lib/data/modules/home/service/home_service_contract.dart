import 'package:devnology_challenge/data/modules/home/response/event_response.dart';

abstract class HomeServiceContract {
  Future<EventResponse> getEvent();
  Future<EventResponse> getEventPerType({required String type});
  Future<EventResponse> getEventPerParticipants({required String participants});
  Future<EventResponse> getEventPerPrice({required double price});
  Future<EventResponse> getEventWithAccessibility({required double accessibility});
}