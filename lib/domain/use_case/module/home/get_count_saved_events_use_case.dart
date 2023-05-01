import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';

class GetCountSavedEvents {
  DatabaseHelperContract databaseHelper;

  GetCountSavedEvents({required this.databaseHelper});

  Future<int> getDatabaseCount() async => databaseHelper.countAllSavedEvents();
}