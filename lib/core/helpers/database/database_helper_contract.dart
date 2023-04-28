import 'package:devnology_challenge/data/modules/saved_events/response/event_response.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelperContract {
  Future<void> validateAndStartDatabase();
  Future<void> insertIntoDatabase({required EventResponse event});
  Future<void> updateDatabase({required EventResponse event});
  Future<List<Map<String, dynamic>>> getAllSavedEvents();
  Future<bool> deleteEvent({required int keyEvent});
  Future<void> createDatabase({required Database database});
}