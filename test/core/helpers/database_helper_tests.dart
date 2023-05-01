import 'package:flutter_test/flutter_test.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:devnology_challenge/core/helpers/database/database_helper.dart';
import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';

void main() {
  late DatabaseHelperContract databaseHelper;

  final EventResponse fakeEvent = EventResponse(
    key: '1',
    accessibility: '0',
    activity: 'Go to the beach',
    participants: '1',
    price: 'Free',
  );

  group('Database helper tests', () {
    setUp(() {
      sqfliteFfiInit();

      // Trocando factory para FFI.
      databaseFactory = databaseFactoryFfi;

      databaseHelper = DatabaseHelper();

      Future.delayed(Duration(microseconds: 500));
    });

    test('When inserting new data into database the result should be true', () async {
      bool result = await databaseHelper.insertIntoDatabase(event: fakeEvent);
      List<Map<String, dynamic>> events = await databaseHelper.getAllSavedEvents();

      expect(result, isTrue);
      expect(events, isNotEmpty);
    });

    test('When counting events on database the result is not zero', () async {
       int currentResultCount = await databaseHelper.countAllSavedEvents();
       expect(currentResultCount, isNot(0));
    });

    test('When inserting new data into database the result should be true', () async {
      bool result = await databaseHelper.deleteEvent(keyEvent: int.parse(fakeEvent.key!));
      List<Map<String, dynamic>> events = await databaseHelper.getAllSavedEvents();

      expect(result, isTrue);
      expect(events, isEmpty);
    });
  });
}
