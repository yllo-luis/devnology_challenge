
import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';

import '../../../../data/modules/home/response/event_response.dart';

class GetEventFromDatabaseUseCase {
  final DatabaseHelperContract databaseHelper;

  GetEventFromDatabaseUseCase({
    required this.databaseHelper,
  });

  Future<List<EventResponse>> getEvent() async {
    List<EventResponse> result = List.empty(growable: true);
    List<Map<String, dynamic>> eventsJson =
        await databaseHelper.getAllSavedEvents();

    for (var element in eventsJson) {
      result.add(
        EventResponse.fromJson(
          element,
        ),
      );
    }

    return result;
  }
}
