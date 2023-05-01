import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelperContract {
  Future<void> validateAndStartDatabase();
  Future<bool> insertIntoDatabase({required EventResponse event});
  Future<void> updateDatabase({required EventResponse event});
  Future<List<Map<String, dynamic>>> getAllSavedEvents();
  Future<int> countAllSavedEvents();
  Future<bool> deleteEvent({required int keyEvent});
  Future<void> createDatabase({required Database database});
}