import 'package:devnology_challenge/data/modules/home/response/event_response.dart';

abstract class HomeServiceContract {
  Future<EventResponse> getEvent();
}
