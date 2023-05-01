
import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';

class DeleteEventFromDatabaseUseCase {
  final DatabaseHelperContract databaseHelper;

  const DeleteEventFromDatabaseUseCase({required this.databaseHelper});

  Future<bool> deleteSavedEvent({required int eventId}) async {
    bool isDeleted = await databaseHelper.deleteEvent(keyEvent: eventId);
    return isDeleted;
  }
}