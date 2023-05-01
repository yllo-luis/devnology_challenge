import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';

class SaveEventsOnDatabaseUseCase {
  final DatabaseHelperContract databaseHelper;

  SaveEventsOnDatabaseUseCase({required this.databaseHelper});

  Future<bool> saveEventsOnDatabase({required EventResponse event}) async =>
      databaseHelper.insertIntoDatabase(event: event);
}
