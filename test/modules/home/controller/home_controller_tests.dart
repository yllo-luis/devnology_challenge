import 'package:devnology_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';
import 'package:devnology_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:devnology_challenge/core/helpers/launcher/launcher_contract.dart';
import 'package:devnology_challenge/data/modules/home/service/home_service_contract.dart';
import 'package:devnology_challenge/domain/use_case/module/home/get_count_saved_events_use_case.dart';
import 'package:devnology_challenge/domain/use_case/module/home/get_event_use_case.dart';
import 'package:devnology_challenge/domain/use_case/module/home/save_events_on_database_use_case.dart';

import 'home_controller_tests.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DatabaseHelperContract>(),
  MockSpec<HomeServiceContract>(),
  MockSpec<LauncherContract>()
])
void main() {
  HomeController? controller;
  late HomeStore homeStore;
  late LauncherContract fakeLauncherContract;
  late HomeServiceContract fakeServiceContract;
  late DatabaseHelperContract fakeDatabaseHelper;
  late GetCountSavedEvents getCountSavedEvents;
  late SaveEventsOnDatabaseUseCase saveEventsOnDatabaseUseCase;
  late GetEventUseCase getEventUseCase;

  group('HomeController tests', () {
    setUp(() {
      fakeDatabaseHelper = MockDatabaseHelperContract();
      fakeLauncherContract = MockLauncherContract();
      fakeServiceContract = MockHomeServiceContract();
      getCountSavedEvents =
          GetCountSavedEvents(databaseHelper: fakeDatabaseHelper);
      saveEventsOnDatabaseUseCase =
          SaveEventsOnDatabaseUseCase(databaseHelper: fakeDatabaseHelper);
      getEventUseCase = GetEventUseCase(homeService: fakeServiceContract);
      fakeLauncherContract = MockLauncherContract();
      homeStore = HomeStore();
    });

    test('When homeController is initialized a event must be fetched',
        () async {
      when(getEventUseCase.getEvent()).thenAnswer(
        (_) => Future.value(
          EventResponse(),
        ),
      );
      when(getCountSavedEvents.getDatabaseCount()).thenAnswer(
        (_) => Future.value(0),
      );

      controller = HomeController(
        homeStore: homeStore,
        getCountSavedEvents: getCountSavedEvents,
        saveEventsOnDatabaseUseCase: saveEventsOnDatabaseUseCase,
        getEventUseCase: getEventUseCase,
        launcherHelper: fakeLauncherContract,
      );

      await Future.delayed(
        Duration(seconds: 1),
      );

      verify(getEventUseCase.getEvent()).called(1);
      verify(getCountSavedEvents.getDatabaseCount()).called(1);
    });

    test(
        'When a event is fetched the stream containing all events must not be null',
        () async {
      controller = HomeController(
        homeStore: homeStore,
        getCountSavedEvents: getCountSavedEvents,
        saveEventsOnDatabaseUseCase: saveEventsOnDatabaseUseCase,
        getEventUseCase: getEventUseCase,
        launcherHelper: fakeLauncherContract,
      );

      when(getEventUseCase.getEvent()).thenAnswer(
        (_) => Future.value(
          EventResponse(),
        ),
      );

      await controller?.getAEvent();

      expect(controller?.homeStore.eventController.length, isNot(0));
      expect(controller?.homeStore.eventController.value, isNotNull);
      expect(controller?.homeStore.eventController.hasError, isFalse);
    });

    test(
        'When a event is saved the database must be called and the event count update',
        () async {
      final fakeEvent = EventResponse();

      controller = HomeController(
        homeStore: homeStore,
        getCountSavedEvents: getCountSavedEvents,
        saveEventsOnDatabaseUseCase: saveEventsOnDatabaseUseCase,
        getEventUseCase: getEventUseCase,
        launcherHelper: fakeLauncherContract,
      );

      controller?.homeStore.eventController.add(fakeEvent);
      final fetchedFakeEvent =
          await controller!.homeStore.eventController.value;

      when(fakeDatabaseHelper.insertIntoDatabase(
        event: fetchedFakeEvent,
      )).thenAnswer(
        (_) => Future.value(true),
      );
      when(fakeDatabaseHelper.countAllSavedEvents()).thenAnswer(
        (_) => Future.value(1),
      );

      bool? result = await controller?.saveCurrentEvent();

      verify(fakeDatabaseHelper.insertIntoDatabase(event: fetchedFakeEvent))
          .called(1);
      verify(fakeDatabaseHelper.countAllSavedEvents()).called(1);
      expect(result, isTrue);
    });

    test('When a event has a url launcher browser helper should be called',
        () async {
      final String fakeUrl = 'http://thisIsAFakeUrl.com';
      final Uri url = Uri.parse(fakeUrl);

      controller = HomeController(
        homeStore: homeStore,
        getCountSavedEvents: getCountSavedEvents,
        saveEventsOnDatabaseUseCase: saveEventsOnDatabaseUseCase,
        getEventUseCase: getEventUseCase,
        launcherHelper: fakeLauncherContract,
      );

      when(fakeLauncherContract.launchUserBrowser(
        uriToLaunch: url,
      )).thenAnswer(
        (_) => Future.value(null),
      );

      await controller?.openWebPage(uri: fakeUrl);

      verify(fakeLauncherContract.launchUserBrowser(uriToLaunch: url))
          .called(1);
    });

    test(
        'When a event does not have a url launcher browser helper should not be called',
        () async {
      final String fakeUrl = 'http://thisIsAFakeUrl.com';
      final Uri url = Uri.parse(fakeUrl);

      controller = HomeController(
        homeStore: homeStore,
        getCountSavedEvents: getCountSavedEvents,
        saveEventsOnDatabaseUseCase: saveEventsOnDatabaseUseCase,
        getEventUseCase: getEventUseCase,
        launcherHelper: fakeLauncherContract,
      );

      when(fakeLauncherContract.launchUserBrowser(
        uriToLaunch: url,
      )).thenAnswer(
        (_) => Future.value(null),
      );

      await controller?.openWebPage(uri: null);

      verifyZeroInteractions(fakeLauncherContract);
    });
  });
}
