import 'dart:io';
import 'dart:developer';

import 'package:catcher/core/catcher.dart';
import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';
import 'package:devnology_challenge/data/modules/saved_events/response/event_response.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/app_constants_utils.dart';

class DatabaseHelper implements DatabaseHelperContract {
  static const databaseName = 'todoReminder';
  Database? database;

  DatabaseHelper() {
    validateAndStartDatabase();
  }

  Future<void> validateAndStartDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = databasePath;
    try {
      if (Directory(path).existsSync() == false) {
        await Directory(path).create(recursive: true);
      }
      database = await openDatabase(
        '$path${'/' + AppConstantsUtils.databaseName}',
        version: 1,
        onCreate: (db, version) => createDatabase(database: db),
      );
    } catch (e, stacktrace) {
      Catcher.reportCheckedError(e, stacktrace);
    }
  }

  Future<void> insertIntoDatabase({required EventResponse event}) async {
    if (database == null) {
      await validateAndStartDatabase();
    }
    await database?.transaction((txn) async {
      int result = await txn.rawInsert(
        'INSERT INTO $databaseName(key, activity, accessibility, type, participants, price, link, dateToEvent) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        List.from(
          event.toJson().values.toList(),
        ),
      );
      log('Database inserted $result');
    });
  }

  Future<void> updateDatabase({required EventResponse event}) async {
    await database
        ?.update(databaseName, event.toJson(), where: 'key = ?', whereArgs: [
      event.key ?? 0,
    ]).then(
      (value) => log(
        'Database updated $value',
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getAllSavedEvents() async {
    List<Map<String, dynamic>> results = await database!.rawQuery(
      'SELECT * FROM $databaseName',
    );
    return results;
  }

  Future<bool> deleteEvent({required int keyEvent}) async {
    int result = await database!.rawDelete(
        'DELETE FROM $databaseName WHERE key = $keyEvent');
    return result != 0;
  }

  Future<void> createDatabase({required Database database}) async {
    database.execute(
      'CREATE TABLE $databaseName (key INTEGER PRIMARY KEY, activity TEXT, accessibility TEXT, type TEXT,participants TEXT, price TEXT, link TEXT, dateToEvent TEXT)',
    );
  }
}
