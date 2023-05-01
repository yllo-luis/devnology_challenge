import 'dart:developer';

import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';
import 'package:devnology_challenge/data/modules/home/service/home_service_contract.dart';

import '../../../../data/modules/home/response/event_response.dart';

class GetEventFromDatabaseUseCase {
  final DatabaseHelperContract databaseHelper;

  GetEventFromDatabaseUseCase({required this.databaseHelper});

  Future<List<EventResponse>> getEvent() async {
    List<EventResponse> result = List.empty(growable: true);
    List<Map<String, dynamic>> eventsJson =
        await databaseHelper.getAllSavedEvents();

    eventsJson.forEach((element) {
      result.add(
        EventResponse.fromJson(
          element,
        ),
      );
    });

    return result;
  }
}
