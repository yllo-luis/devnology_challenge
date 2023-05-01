import 'dart:io';
import 'dart:developer';

import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/app_constants_utils.dart';

class DatabaseHelper implements DatabaseHelperContract {
  static const databaseName = 'todoReminder';
  Database? database;

  DatabaseHelper() {
    validateAndStartDatabase();
  }

  @override
  Future<void> validateAndStartDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = databasePath;
    try {
      if (Directory(path).existsSync() == false) {
        await Directory(path).create(recursive: true);
      }
      database = await openDatabase(
        '$path${'/${AppConstantsUtils.databaseName}'}',
        version: 1,
        onCreate: (db, version) => createDatabase(database: db),
      );
    } catch (e, stacktrace) {
      log('Database error', stackTrace: stacktrace);
    }
  }

  @override
  Future<bool> insertIntoDatabase({required EventResponse event}) async {
    if (database == null) {
      await validateAndStartDatabase();
    }
    try {
      int? result = await database?.rawInsert(
        'INSERT INTO $databaseName(key, activity, accessibility, type, participants, price, link) VALUES (?, ?, ?, ?, ?, ?, ?)',
        List.from(
          event.toJson().values.toList(),
        ),
      );
      return result != 0;
    } catch (e, stacktrace) {
      log('Database error', error: e.toString(), stackTrace: stacktrace);
    }
    return false;
  }

  @override
  Future<void> updateDatabase({required EventResponse event}) async {
    if (database == null) {
      await validateAndStartDatabase();
    }
    await database
        ?.update(databaseName, event.toJson(), where: 'key = ?', whereArgs: [
      event.key ?? 0,
    ]).then(
      (value) => log(
        'Database updated $value',
      ),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAllSavedEvents() async {
    if (database == null) {
      await validateAndStartDatabase();
    }
    List<Map<String, dynamic>> results = await database!.rawQuery(
      'SELECT * FROM $databaseName',
    );
    return results;
  }

  @override
  Future<bool> deleteEvent({required int keyEvent}) async {
    if (database == null) {
      await validateAndStartDatabase();
    }
    int result = await database!
        .rawDelete('DELETE FROM $databaseName WHERE key = $keyEvent');
    return result != 0;
  }

  @override
  Future<void> createDatabase({required Database database}) async {
    database.execute(
      'CREATE TABLE $databaseName (key TEXT PRIMARY KEY, activity TEXT, accessibility TEXT, type TEXT,participants TEXT, price TEXT, link TEXT)',
    );
  }

  @override
  Future<int> countAllSavedEvents() async {
    if (database == null) {
      await validateAndStartDatabase();
    }
    List<Map<String, dynamic>> results = await database!.rawQuery(
      'SELECT * FROM $databaseName',
    );
    return results.length;
  }
}
