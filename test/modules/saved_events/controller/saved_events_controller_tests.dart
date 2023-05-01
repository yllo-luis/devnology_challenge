import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:devnology_challenge/app/modules/saved_events/presenter/controller/saved_events_controller.dart';
import 'package:devnology_challenge/app/modules/saved_events/presenter/store/saved_events_store.dart';
import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';
import 'package:devnology_challenge/core/helpers/launcher/launcher_contract.dart';
import 'package:devnology_challenge/domain/use_case/module/saved_events/delete_event_from_database_use_case.dart';
import 'package:devnology_challenge/domain/use_case/module/saved_events/get_event_from_database_use_case.dart';

import 'saved_events_controller_tests.mocks.dart';


@GenerateNiceMocks([
  MockSpec<LauncherContract>(),
  MockSpec<DatabaseHelperContract>(),
])
void main() {
  SavedEventsController? savedEventsController;
  late GetEventFromDatabaseUseCase getEventFromDatabaseUseCase;
  late DeleteEventFromDatabaseUseCase deleteEventFromDatabaseUseCase;
  late LauncherContract fakeLaunchContract;
  late DatabaseHelperContract fakeDatabase;
  late SavedEventsStore savedEventsStore;

  group('Saved Events controller tests', () {
    setUp(() {
      fakeDatabase = MockDatabaseHelperContract();
      getEventFromDatabaseUseCase =
          GetEventFromDatabaseUseCase(databaseHelper: fakeDatabase);
      deleteEventFromDatabaseUseCase =
          DeleteEventFromDatabaseUseCase(databaseHelper: fakeDatabase);
      fakeLaunchContract = MockLauncherContract();
      savedEventsStore = SavedEventsStore();
    });

    test(
        'When saved events controller is initialized the events must be fetched immediately',
        () {
      when(fakeDatabase.getAllSavedEvents()).thenAnswer(
        (_) => Future.value(
          List<Map<String, dynamic>>.generate(
            2,
            (index) => {},
          ),
        ),
      );

      savedEventsController = SavedEventsController(
        getEventFromDatabaseUseCase: getEventFromDatabaseUseCase,
        deleteEventFromDatabaseUseCase: deleteEventFromDatabaseUseCase,
        savedEventsStore: savedEventsStore,
        launcherHelper: fakeLaunchContract,
      );

      Future.delayed(const Duration(seconds: 1));

      verify(fakeDatabase.getAllSavedEvents()).called(1);
      expect(
        savedEventsController!.savedEventsStore.currentEventsStream.length,
        isNot(0),
      );
    });

    test('When deleting events then stream must be updated', () async {
      const int fakeId = 0;

      when(fakeDatabase.getAllSavedEvents()).thenAnswer(
        (_) => Future.value(
          List<Map<String, dynamic>>.generate(
            1,
            (index) => {},
          ),
        ),
      );
      when(fakeDatabase.deleteEvent(keyEvent: fakeId));

      savedEventsController = SavedEventsController(
        getEventFromDatabaseUseCase: getEventFromDatabaseUseCase,
        deleteEventFromDatabaseUseCase: deleteEventFromDatabaseUseCase,
        savedEventsStore: savedEventsStore,
        launcherHelper: fakeLaunchContract,
      );

      Future.delayed(const Duration(seconds: 1));

      await deleteEventFromDatabaseUseCase.deleteSavedEvent(eventId: fakeId);

      verify(fakeDatabase.getAllSavedEvents()).called(isNot(0));
      verify(fakeDatabase.deleteEvent(keyEvent: fakeId)).called(isNot(0));
      expect(
        savedEventsController!.savedEventsStore.currentEventsStream.length,
        isNot(0),
      );
    });
  });
}
