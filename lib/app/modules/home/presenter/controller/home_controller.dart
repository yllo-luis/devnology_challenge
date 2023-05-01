import 'package:devnology_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:devnology_challenge/core/constants/app_constants_utils.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:devnology_challenge/domain/entity/event_entity.dart';
import 'package:devnology_challenge/domain/use_case/module/home/get_count_saved_events_use_case.dart';
import 'package:devnology_challenge/domain/use_case/module/home/get_event_use_case.dart';
import 'package:devnology_challenge/domain/use_case/module/home/save_events_on_database_use_case.dart';

class HomeController {
  final HomeStore homeStore;
  final SaveEventsOnDatabaseUseCase saveEventsOnDatabaseUseCase;
  final GetCountSavedEvents getCountSavedEvents;
  final GetEventUseCase getEventUseCase;

  HomeController({
    required this.homeStore,
    required this.getCountSavedEvents,
    required this.saveEventsOnDatabaseUseCase,
    required this.getEventUseCase,
  }) {
    init();
  }

  void init() async {
    await Future(() {
      getAEvent();
      countSavedEvents();
    });
  }

  Future<void> getAEvent() async {
    await getEventUseCase.getEvent().then((value) {
      homeStore.addEvent(response: value);
    }, onError: (error) {
      homeStore.eventController.addError(error);
    });
  }

  Future<void> saveCurrentEvent() async {
    final EventResponse savedEvents = await homeStore.eventController.value;
    await saveEventsOnDatabaseUseCase
        .saveEventsOnDatabase(event: savedEvents)
        .whenComplete(
          () => countSavedEvents(),
        );
  }

  Future<void> countSavedEvents() async {
    await getCountSavedEvents.getDatabaseCount().then((value) {
      homeStore.addCountEvent(countEvent: value);
    }, onError: (error) {
      homeStore.savedEventsController.addError(error);
    });
  }

  Future<void> resetDialogData() async {
    homeStore.priceNotifier.value = AppConstantsUtils.minPriceValue;
    homeStore.accessibilityNotifier.value =
        AppConstantsUtils.minAccessibilityValue;
    homeStore.participantsNotifier.value =
        AppConstantsUtils.minParticipantsValue;
  }
}
