import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:devnology_challenge/data/modules/home/service/home_service_contract.dart';
import 'package:devnology_challenge/data/api/api_constants.dart';

class HomeService implements HomeServiceContract {
  final dio = Dio();

  @override
  Future<EventResponse> getEvent() async {
    Response httpResponse;
    httpResponse = await dio.get(ApiConstants.serverUrlActivityEndpoint);
    if (httpResponse.statusCode == 200) {
      return EventResponse.fromJson(
        httpResponse.data,
      );
    }
    throw Exception(
      httpResponse.statusCode.toString() +
          httpResponse.statusMessage.toString(),
    );
  }

  @override
  Future<EventResponse> getEventPerParticipants(
      {required String participants}) {
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
  Future<EventResponse> getEventWithAccessibility(
      {required double accessibility}) {
    // TODO: implement getEventWithAccessibility
    throw UnimplementedError();
  }
}
